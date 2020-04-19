import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_estate/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  set email(String email) {
    _email = email;
  }

  set password(String password) {
    _password = password;
  }

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //sign in with email & password
  Future get signInWithEmailAndPassword async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // register with email & password
  Future get registerWithEmailAndPassword async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
