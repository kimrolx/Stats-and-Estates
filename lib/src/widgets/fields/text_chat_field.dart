import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyTextChatField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextChatField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Form(
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'DMSansRegular',
          color: Colors.white,
          fontSize: width * 0.04,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'DMSansRegular',
            color: Colors.white,
            fontSize: width * 0.045,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        cursorColor: splashColor,
      ),
    );
  }
}
