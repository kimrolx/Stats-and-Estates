import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/services/chat/chat_service.dart';
import 'package:stats_and_estates/src/utils/image_picker_util.dart';
import 'package:stats_and_estates/src/widgets/chat_bubble_builder.dart';
import 'package:stats_and_estates/src/widgets/fields/text_chat_field.dart';
import 'package:stats_and_estates/src/widgets/user_components_builder.dart';

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

  final List<Uint8List?> _images = List.generate(3, (index) => null);

  void selectImage(int index) async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _images[index] = img;
      });
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

      var crossAlignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start;

      var mainAlignment = (data['senderID'] == _firebaseAuth.currentUser!.uid)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start;

      return Container(
        alignment: alignment,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.025,
            vertical: height * 0.005,
          ),
          child: Column(
            crossAxisAlignment: crossAlignment,
            mainAxisAlignment: mainAlignment,
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
            GestureDetector(
              onTap: () {
                int nullIndex = _images.indexWhere((img) => img == null);
                if (nullIndex != -1) {
                  selectImage(nullIndex);
                }
              },
              child: Icon(
                CupertinoIcons.plus_circle_fill,
                size: width * 0.085,
                color: navigationBarColor,
              ),
            ),
            Gap(width * 0.02),
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                //TODO
              },
              icon: const Icon(CupertinoIcons.phone_fill),
            ),
          ],
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: [
              const CircleAvatar(
                radius: 20,
              ),
              Gap(height * 0.01),
              InkWell(
                //TODO
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ConversationOptions(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.fastOutSlowIn;
                        return SlideTransition(
                          position: Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve))
                              .animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.0, 0.55),
                                ),
                              ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.receiverUserName,
                      style: TextStyle(
                        fontFamily: 'DMSansBold',
                        fontSize: width * 0.045,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontFamily: 'DMSansBold',
                        fontSize: width * 0.035,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Column(
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
    );
  }
}

class ConversationOptions extends StatelessWidget {
  const ConversationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.025,
                vertical: height * 0.015,
              ),
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: splashColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  children: [
                    MyUserComponent(
                      text: 'Block',
                      icon: CupertinoIcons.minus_circle_fill,
                    ),
                    MyUserComponent(
                      text: 'Report',
                      icon: CupertinoIcons.exclamationmark_triangle_fill,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
