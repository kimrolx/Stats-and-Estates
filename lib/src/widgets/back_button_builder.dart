import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: width * 0.14,
          height: height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: buttonColor,
          ),
          child: Center(
            child: Icon(
              CupertinoIcons.back,
              color: Colors.white,
              size: width * 0.07,
            ),
          ),
        ),
      ),
    );
  }
}
