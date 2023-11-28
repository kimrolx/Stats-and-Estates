import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/services/chat/chat_service.dart';
import 'package:stats_and_estates/src/widgets/back_button_builder.dart';
import 'package:stats_and_estates/src/widgets/chat_bubble_builder.dart';
import 'package:stats_and_estates/src/widgets/fields/text_chat_field.dart';

class ConversationPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserID;
  const ConversationPage(
      {super.key,
      required this.receiverUserName,
      required this.receiverUserID});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    //Only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      //Clear the text controller after sending the message.
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Build message item
    Widget buildMessageItem(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      //Align the messages to the right if the sender is the current user, otherwise to the left
      var alignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
          ? Alignment.centerRight
          : Alignment.centerLeft;

      return Container(
        alignment: alignment,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.025,
            vertical: height * 0.005,
          ),
          child: Column(
            crossAxisAlignment:
                (data['senderID'] == _firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                (data['senderID'] == _firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              MyChatBubble(
                message: data['message'],
                senderID: data['senderID'],
              ),
            ],
          ),
        ),
      );
    }

    //Build message list
    Widget buildMessageList() {
      return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: snapshot.data!.docs
                .map((document) => buildMessageItem(document))
                .toList(),
          );
        },
      );
    }

    //Build message input
    Widget buildMessageInput() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.01,
        ),
        child: Row(
          children: [
            //Textfield
            Expanded(
              child: MyTextChatField(
                controller: _messageController,
                hintText: 'Aa',
                obscureText: false,
                sendMessage: sendMessage,
              ),
            ),
          ],
        ),
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
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: backgroundColor,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.035,
                vertical: height * 0.055,
              ),
              child: const MyBackButton(),
            ),
            Positioned(
              top: height * 0.15,
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: height * 0.5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.01,
                      right: width * 0.01,
                      top: height * 0.125,
                    ),
                    child: Column(
                      children: [
                        //Messages
                        Expanded(
                          child: buildMessageList(),
                        ),

                        //User Input
                        buildMessageInput(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: height * 0.075),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                  ),
                  Gap(height * 0.01),
                  Text(
                    widget.receiverUserName,
                    style: TextStyle(
                      fontFamily: 'DMSansBold',
                      fontSize: width * 0.05,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
