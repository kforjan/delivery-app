import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DeliverModel with ChangeNotifier {
  Position position;

  Future<void> updateLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _updateWith(position: position);
  }

  void _updateWith({
    Position position,
  }) {
    this.position = position ?? this.position;
    notifyListeners();
  }
}
