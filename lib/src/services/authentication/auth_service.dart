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

  //Create new user
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, password) async {
    try {
      //Sign up
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
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

  //Logout user
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
