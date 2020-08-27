import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/app/home/order/models/order.dart';

import './api_path.dart';

enum UserType {
  order,
  deliver,
}

abstract class Database {
  Future<void> addOrder(Order order);
  Future<void> addUserType(String userId, UserType userType);
  Stream<UserType> getUserTypeStream(String userId);
}

class FirestoreDatabase implements Database {
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

  @override
  Future<void> addOrder(Order order) async {
    final instance = Firestore.instance.document(ApiPath.order(order.id));
    instance.setData(order.toMap());
  }
}
