import 'package:flutter/foundation.dart';

class Order {
  Order({
    @required this.id,
    @required this.isActive,
    @required this.mealCount,
    @required this.sideMealCount,
    @required this.drinkCount,
    @required this.longitude,
    @required this.latitude,
    this.currentLongitude,
    this.currentLatitude,
  });

  final String id;
  bool isActive;
  final int mealCount;
  final int sideMealCount;
  final int drinkCount;
  final double longitude;
  final double latitude;
  double currentLongitude;
  double currentLatitude;

  Map<String, dynamic> toMap() {
    return {
      'mealCount': this.mealCount,
      'isActive': this.isActive,
      'sideMealCount': this.sideMealCount,
      'drinkCount': this.drinkCount,
      'longitude': this.longitude,
      'latitude': this.latitude,
      'currentLatitude': this.currentLatitude,
      'currentLongitude': this.currentLongitude,
    };
  }

  static Order fromMap(Map<String, dynamic> orderData, String id) {
    return Order(
      id: id,
      isActive: orderData['isActive'],
      mealCount: orderData['mealCount'],
      sideMealCount: orderData['sideMealCount'],
      drinkCount: orderData['drinkCount'],
      longitude: orderData['longitude'],
      latitude: orderData['latitude'],
      currentLongitude: orderData['currentLongitude'],
      currentLatitude: orderData['currentLatitude'],
    );
  }
}
