import 'package:delivery_app/app/home/models/order.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class OrderModel with ChangeNotifier {
  int mealCount = 0;
  int sideMealCount = 0;
  int drinkCount = 0;
  Position position;
  bool located = false;

  void updateMealCount(int mealCount) {
    _updateWith(mealCount: mealCount);
  }

  void updateSideMealCount(int sideMealCount) {
    _updateWith(sideMealCount: sideMealCount);
  }

  void updateDrinkCount(int drinkCount) {
    _updateWith(drinkCount: drinkCount);
  }

  Future<void> updateLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _updateWith(position: position);
    toggleLocatedStatus();
  }

  void toggleLocatedStatus() {
    _updateWith(located: !this.located);
  }

  bool isOrderable() {
    return located == true &&
        (mealCount != 0 || sideMealCount != 0 || drinkCount != 0);
  }

  Order generateOrder() {
    return Order(
      id: DateTime.now().toIso8601String(),
      isActive: false,
      mealCount: this.mealCount,
      sideMealCount: this.sideMealCount,
      drinkCount: this.drinkCount,
      longitude: position.longitude,
      latitude: position.latitude,
    );
  }

  void _updateWith({
    int mealCount,
    int sideMealCount,
    int drinkCount,
    Position position,
    bool located,
  }) {
    this.mealCount = mealCount ?? this.mealCount;
    this.sideMealCount = sideMealCount ?? this.sideMealCount;
    this.drinkCount = drinkCount ?? this.drinkCount;
    this.position = position ?? this.position;
    this.located = located ?? this.located;
    notifyListeners();
  }
}
