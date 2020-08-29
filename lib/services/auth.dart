import 'package:firebase_auth/firebase_auth.dart';

class User {
  User({
    this.userId,
  });
  String userId;
}

abstract class AuthBase {
  Stream<User> get onAuthChanged;
  Future<User> get currentUser;
  Future<User> signIn();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      userId: user.uid,
    );
  }

  @override
  Stream<User> get onAuthChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> get currentUser async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signIn() async {
    try {
      final _authResult = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(_authResult.user);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
