import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyListingInfoField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const MyListingInfoField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Form(
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'DMSansRegular',
          color: buttonColor,
          fontSize: width * 0.04,
        ),
        decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          labelStyle: TextStyle(
            fontFamily: 'DMSansRegular',
            fontSize: width * 0.055,
            fontWeight: FontWeight.w500,
            color: buttonColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: buttonColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: buttonColor),
          ),
        ),
        cursorColor: buttonColor,
      ),
    );
  }
}
