import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/app/home/models/order.dart';
import 'package:geolocator/geolocator.dart';
import './api_path.dart';

enum UserType {
  order,
  deliver,
}

abstract class Database {
  Future<void> addOrder(Order order);
  Future<void> addUserType(String userId, UserType userType);
  Stream<Order> getOrder(Order order);
  Stream<UserType> getUserTypeStream(String userId);
  Stream<List<Order>> getOrdersStream();
  Future<void> updateDeliveryStatus(Order order);
  Future<void> updateCurrentOrderLocation(Order order, Position position);
}

class FirestoreDatabase implements Database {
  @override
  Future<void> addOrder(Order order) async {
    final instance = Firestore.instance.document(ApiPath.order(order.id));
    print(order.id);
    print(order.currentLatitude);
    instance.setData(order.toMap());
  }

  @override
  Stream<Order> getOrder(Order order) {
    final orderSnapshot = Firestore.instance
        .collection(ApiPath.orders())
        .document(order.id)
        .snapshots();
    return orderSnapshot
        .map((event) => Order.fromMap(event.data, event.documentID));
  }

  @override
  Stream<List<Order>> getOrdersStream() {
    final ordersSnapshot =
        Firestore.instance.collection(ApiPath.orders()).snapshots();
    return ordersSnapshot.map(
      (event) => event.documents
          .map((e) => Order.fromMap(e.data, e.documentID))
          .toList(),
    );
  }

  @override
  Future<void> updateCurrentOrderLocation(
      Order order, Position position) async {
    Order newOrder = Order(
      id: order.id,
      mealCount: order.mealCount,
      sideMealCount: order.sideMealCount,
      drinkCount: order.drinkCount,
      latitude: order.latitude,
      longitude: order.longitude,
      isActive: order.isActive,
      currentLatitude: position.latitude,
      currentLongitude: position.longitude,
    );
    await addOrder(newOrder);
  }

  @override
  Future<void> updateDeliveryStatus(Order order) async {
    Order newOrder = Order(
      id: order.id,
      mealCount: order.mealCount,
      sideMealCount: order.sideMealCount,
      drinkCount: order.drinkCount,
      latitude: order.latitude,
      longitude: order.longitude,
      isActive: true,
      currentLatitude: order.currentLatitude,
      currentLongitude: order.currentLongitude,
    );
    await addOrder(newOrder);
  }

  @override
  Future<void> addUserType(String userId, UserType userType) async {
    final instance = Firestore.instance.document(ApiPath.user(userId));
    instance.setData(
      userType == UserType.order
          ? {
              'type': 'order',
            }
          : {
              'type': 'deliver',
            },
    );
  }

  @override
  Stream<UserType> getUserTypeStream(String userId) {
    final instance = Firestore.instance.collection('users').document(userId);
    final userTypeStream = instance
        .snapshots()
        .map((snapshot) => snapshot.data)
        .map((data) => mapToUserType(data));
    return userTypeStream;
  }

  UserType mapToUserType(Map<String, dynamic> data) {
    return data['type'] == 'order' ? UserType.order : UserType.deliver;
  }
}
