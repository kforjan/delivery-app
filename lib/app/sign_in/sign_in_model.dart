import 'package:flutter/widgets.dart';

class SignInModel with ChangeNotifier {
  bool isLoading = false;

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
