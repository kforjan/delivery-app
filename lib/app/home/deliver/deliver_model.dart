import 'package:delivery_app/app/home/models/order.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DeliverModel with ChangeNotifier {
  Position position;
  Order order;
  bool isActiveDelivery = false;
  Geolocator _geolocator = Geolocator();

  Future<void> setLocation() async {
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _updateWith(position: position);
  }

  void updatePosition(Position position) {
    _updateWith(position: position);
  }

  void updateOrder(Order order) {
    _updateWith(order: order);
  }

  void toggleIsActiveDelivery() {
    _updateWith(isActiveDelivery: !isActiveDelivery);
  }

  void _updateWith({
    Position position,
    Order order,
    bool isActiveDelivery,
  }) {
    this.position = position ?? this.position;
    this.order = order ?? this.order;
    this.isActiveDelivery = isActiveDelivery ?? this.isActiveDelivery;
    notifyListeners();
  }
}
