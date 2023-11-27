import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyTextChatField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Function sendMessage;
  const MyTextChatField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.sendMessage,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Material(
      borderRadius: BorderRadius.circular(15),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'DMSansRegular',
          color: Colors.black,
          fontSize: width * 0.035,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: splashColor,
          hintText: hintText,
          labelStyle: TextStyle(
            fontFamily: 'DMSansRegular',
            fontSize: width * 0.05,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.black54),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: Icon(
              CupertinoIcons.arrow_up_circle_fill,
              color: navigationBarColor,
              size: width * 0.08,
            ),
          ),
        ),
        cursorColor: navigationBarColor,
      ),
    );
  }
}
