import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyChatBubble extends StatelessWidget {
  final String message;
  final String senderID;
  const MyChatBubble(
      {super.key, required this.message, required this.senderID});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    Color bubbleColor = (senderID == firebaseAuth.currentUser!.uid)
        ? navigationBarColor
        : splashColor;

    Color textColor = (senderID == firebaseAuth.currentUser!.uid)
        ? Colors.white
        : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.025,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bubbleColor,
      ),
      child: Text(
        message,
        style: TextStyle(
          fontFamily: 'DMSansRegular',
          fontSize: width * 0.04,
          color: textColor,
        ),
      ),
    );
  }
}
