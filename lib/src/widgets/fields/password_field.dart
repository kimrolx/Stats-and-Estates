import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Form(
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
          fontFamily: 'DMSansRegular',
          color: Colors.white,
          fontSize: width * 0.04,
        ),
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            fontFamily: 'DMSansRegular',
            fontSize: width * 0.055,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: splashColor),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
