import 'package:flutter/foundation.dart';

class Order {
  Order({
    @required this.id,
    @required this.mealCount,
    @required this.sideMealCount,
    @required this.drinkCount,
    @required this.longitude,
    @required this.latitude,
  });

  final String id;
  final int mealCount;
  final int sideMealCount;
  final int drinkCount;
  final double longitude;
  final double latitude;

  Map<String, dynamic> toMap() {
    return {
      'mealCount': this.mealCount,
      'sideMealCount': this.sideMealCount,
      'drinkCount': this.drinkCount,
      'longitude': this.longitude,
      'latitude': this.latitude,
    };
  }

  static Order fromMap(Map<String, dynamic> orderData) {
    return Order(
      id: '',
      mealCount: orderData['mealCount'],
      sideMealCount: orderData['sideMealCount'],
      drinkCount: orderData['drinkCount'],
      longitude: orderData['longitude'],
      latitude: orderData['latitude'],
    );
  }
}
