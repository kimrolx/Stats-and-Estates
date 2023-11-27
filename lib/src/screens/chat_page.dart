import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/screens/conversation_page.dart';

class ChatPage extends StatelessWidget {
  final int tab;
  ChatPage({super.key, required this.tab});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Widget buildUserListItem(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      //Display all users except current user
      if (_auth.currentUser!.email != data['email']) {
        return ListTile(
          title: Text(data['email']),
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => ConversationPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                ),
              ),
            );
          },
        );
      } else {
        return Container();
      }
    }

    Widget buildUserList() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => buildUserListItem(doc))
                .toList(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: buildUserList(),
    );
  }
}
