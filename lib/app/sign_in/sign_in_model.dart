import 'package:flutter/foundation.dart';

import '../../services/auth.dart';
import '../../constants/strings.dart';

enum SignInFormType {
  signIn,
  register,
}

class SignInModel with ChangeNotifier {
  SignInModel({
    @required this.auth,
    this.isLoading = false,
  });

  final AuthBase auth;
  bool isLoading;

  Future<void> registerOrder() async {
    _updateWith(
      isLoading: true,
    );
    try {
      await auth.signIn();
    } catch (error) {
      _updateWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> registerDeliver() async {
    _updateWith(
      isLoading: true,
    );
    try {
      await auth.signIn();
    } catch (error) {
      _updateWith(isLoading: false);
      rethrow;
    }
  }

  void _updateWith({
    bool isLoading,
  }) {
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }
}
