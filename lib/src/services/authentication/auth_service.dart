import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //Login user
  Future<UserCredential> signInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      //Login
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      users.doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Create new user with additional details
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
        'address': "",
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Read User Details
  Future<Map<String, dynamic>?> getUserDetails(String userID) async {
    try {
      DocumentSnapshot userSnapshot = await users.doc(userID).get();

      return userSnapshot.exists
          ? userSnapshot.data() as Map<String, dynamic>
          : null;
    } catch (e) {
      debugPrint('Error getting user details: $e');
      return null;
    }
  }

  //Update User Details in Firestore Database
  Future<void> updateFirestoreUserDetails(String userId, String newEmail,
      String newNumber, String newAddress) async {
    try {
      await users.doc(userId).update({
        'email': newEmail,
        'number': newNumber,
        'address': newAddress,
      });
    } catch (error) {
      debugPrint('Error deleting user details: $error');
    }
  }

  //Update User Details in Firebase Authentication
  Future<void> updateUserFromFirebaseAuth(String newEmail) async {
    try {
      User? currentUser = _firebaseAuth.currentUser;

      await currentUser?.updateEmail(newEmail);
    } catch (error) {
      debugPrint('Error deleting user from auth: $error');
    }
  }

  //Delete User from Firestore Database
  Future<void> deleteFirestoreUserDetails(String docID) async {
    try {
      await users.doc(docID).delete();
    } catch (error) {
      debugPrint('Error deleting user details: $error');
    }
  }

  //Delete User from Firebase Authentication
  Future<void> deleteUserFromFirebaseAuth() async {
    try {
      User? currentUser = _firebaseAuth.currentUser;

      await currentUser?.delete();
    } catch (error) {
      debugPrint('Error deleting user from auth: $error');
    }
  }

  //Logout user
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
