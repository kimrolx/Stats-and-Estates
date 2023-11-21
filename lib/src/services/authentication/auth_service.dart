import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Login user
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      //Login
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    }
    //Catch errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Logout
  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }
}
