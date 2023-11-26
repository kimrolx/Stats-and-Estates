import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MySearchBar extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  const MySearchBar(
      {super.key, required this.controller, required this.labelText});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      borderRadius: BorderRadius.circular(30),
      elevation: 5.0,
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
          fontFamily: 'DMSansRegular',
          color: Colors.black,
          fontSize: width * 0.035,
        ),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.labelText,
          labelStyle: TextStyle(
            fontFamily: 'DMSansRegular',
            fontSize: width * 0.025,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
              color: navigationBarColor,
              size: width * 0.08,
            ),
          ),
        ),
        cursorColor: splashColor,
      ),
    );
  }
}
