import 'package:flutter/widgets.dart';

class RoleSelectionModel with ChangeNotifier {
  bool isLoading = false;

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
