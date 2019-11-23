import 'package:cafe_nook/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj base on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }
  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser user = authResult.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      print( err.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
     FirebaseUser user = result.user; 
     return _userFromFirebaseUser(user);
    }
    catch(err) {
      print('sign in error: $err');
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser user = result.user; 
     return _userFromFirebaseUser(user);
    }
    catch(err) {
      print('register error: $err');
      return null;
    }
  }

  // sign out
  Future signOut () async {
    try { 
      return await _auth.signOut();
    } catch(err) {
      print('sign out error: $err');
      return null;
    }
  }

}
