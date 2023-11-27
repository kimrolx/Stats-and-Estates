import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/models/message.dart';

class ChatService extends ChangeNotifier {
  //Get Instance of Auth and Firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Send Message
  Future<void> sendMessage(String receiverID, String message) async {
    //Get current user info
    final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //Create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //Construct chat room ID from current user and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //Sort the IDs (this ensures the chat room id is always the same for any pair of two people)
    String chatRoomID = ids.join(
        "_"); //Combine the IDs into a single string to use as a chatroomID

    //Add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //Get Message
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    //Construct chat room ID from userr IDs (sorted to ensure it matches the id used when sending messages)
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
