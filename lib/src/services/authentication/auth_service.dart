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
        'address': null,
      });

      return userCredential;
    }
    //Catch errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Update Profile
  Future<void> updateProfile(
    String userID, {
    String? newEmail,
    String? newNumber,
    String? newAddress,
  }) async {
    try {
      // Reference to the user's document in Firestore
      DocumentReference<Map<String, dynamic>> userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userID);

      // Create a map with fields to update
      Map<String, dynamic> updates = {};

      // Add new email to updates if provided
      if (newEmail != null) {
        updates['email'] = newEmail;
      }

      // Add new number to updates if provided
      if (newNumber != null) {
        updates['number'] = newNumber;
      }

      // Add new address to updates if provided
      if (newAddress != null) {
        updates['address'] = newAddress;
      }

      // Update the document in Firestore
      await userDocRef.update(updates);
    } catch (e) {
      debugPrint(e.toString());
      // Handle the error as needed
    }
  }

  //Logout user
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
