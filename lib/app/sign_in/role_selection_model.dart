import 'package:flutter/widgets.dart';

class RoleSelection with ChangeNotifier {
  bool isLoading = false;

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
