import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyFavoritesButton extends StatefulWidget {
  final bool isBookMarked;
  final VoidCallback onTap;

  const MyFavoritesButton(
      {super.key, required this.isBookMarked, required this.onTap});

  @override
  State<MyFavoritesButton> createState() => _MyFavoritesButtonState();
}

class _MyFavoritesButtonState extends State<MyFavoritesButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: width * 0.14,
        height: height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: buttonColor,
        ),
        child: Center(
          child: Icon(
            widget.isBookMarked
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart,
            size: width * 0.07,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
