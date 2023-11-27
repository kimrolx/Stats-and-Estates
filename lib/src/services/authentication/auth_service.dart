import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

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

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
      }, SetOptions(merge: true));

      return userCredential;
    }
    //Catch errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Create new user
  Future<UserCredential> signUpUserWithEmailAndPassword(
      String email, password, firstName, lastName, number) async {
    try {
      //Sign up
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'first name': firstName,
        'last name': lastName,
        'number': number,
      });

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
