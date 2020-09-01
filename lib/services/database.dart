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
  Stream<Order> getOrder(String orderId);
  Stream<UserType> getUserTypeStream(String userId);
  Stream<List<Order>> getOrdersStream();
  void deleteOrder(String orderId);
  Future<void> updateDeliveryStatus(Order order);
  Future<void> updateCurrentOrderLocation(Order order, Position position);
  Future<void> finishDelivery(Order order);
}

class FirestoreDatabase implements Database {
  @override
  Future<void> addOrder(Order order) async {
    final instance = Firestore.instance.document(ApiPath.order(order.id));
    instance.setData(order.toMap());
  }

  @override
  Stream<Order> getOrder(String orderId) {
    final orderSnapshot = Firestore.instance
        .collection(ApiPath.orders())
        .document(orderId)
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

  void deleteOrder(String orderId) {
    Firestore.instance.collection(ApiPath.orders()).document(orderId).delete();
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
      isDone: order.isDone,
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
      isDone: order.isDone,
      currentLatitude: order.currentLatitude,
      currentLongitude: order.currentLongitude,
    );
    await addOrder(newOrder);
  }

  @override
  Future<void> finishDelivery(Order order) async {
    Order newOrder = Order(
      id: order.id,
      mealCount: order.mealCount,
      sideMealCount: order.sideMealCount,
      drinkCount: order.drinkCount,
      latitude: order.latitude,
      longitude: order.longitude,
      isActive: order.isActive,
      isDone: true,
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
