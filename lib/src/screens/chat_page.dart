import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/screens/conversation_page.dart';
import 'package:stats_and_estates/src/services/chat/chat_service.dart';
import 'package:stats_and_estates/src/services/notifications/notification_service.dart';

class ChatPage extends StatelessWidget {
  final int tab;
  ChatPage({super.key, required this.tab});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ChatService chatService = ChatService();

    Widget buildUserListItem(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      // Display all users except the current user
      if (_auth.currentUser!.email != data['email']) {
        return StreamBuilder<DocumentSnapshot<Object?>?>(
          stream: chatService.getLastMessageStream(
              _auth.currentUser!.uid, data['uid']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }

            var lastMessage = snapshot.data;
            var lastMessageText = lastMessage != null
                ? lastMessage['message'] ?? 'No messages yet'
                : 'No messages yet';

            // Check if the last message was sent by the current user
            bool currentUserSentLastMessage = lastMessage != null &&
                lastMessage['senderID'] == _auth.currentUser!.uid;

            // Check if the last message was sent to the current user
            bool currentUserReceivedLastMessage = lastMessage != null &&
                lastMessage['receiverID'] == _auth.currentUser!.uid;

            // Modify the subtitle based on the sender
            var subtitleText = currentUserSentLastMessage
                ? 'You: $lastMessageText'
                : lastMessageText;

            // Trigger notification when a new message arrives and the user is logged in
            if (snapshot.hasData &&
                _auth.currentUser != null &&
                !currentUserSentLastMessage &&
                currentUserReceivedLastMessage) {
              NotificationService.showNotification(
                title:
                    'New Message from ${data['first name']} ${data['last name']}',
                body: lastMessageText,
              );
            }

            return Card(
              elevation: 2,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.025,
                ),
                title: Text(
                  data['first name'] + ' ' + data['last name'],
                  style: TextStyle(
                    fontFamily: 'DMSansMedium',
                    fontSize: width * 0.045,
                  ),
                ),
                subtitle: Text(subtitleText),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => ConversationPage(
                        receiverUserName:
                            data['first name'] + ' ' + data['last name'],
                        receiverUserID: data['uid'],
                      ),
                    ),
                  );
                },
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
            return const Text('Loading...');
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map<Widget>((doc) => buildUserListItem(doc))
                .toList(),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          centerTitle: true,
          title: const Text(
            'Chats',
            style: TextStyle(
              fontFamily: 'DMSansBold',
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.025,
              vertical: height * 0.015,
            ),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: splashColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      fontFamily: 'DMSansRegular',
                      color: Colors.white,
                      fontSize: width * 0.045,
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(
                        CupertinoIcons.search,
                        size: width * 0.06,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  cursorColor: buttonColor,
                ),
                Gap(height * 0.025),
                buildUserList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
