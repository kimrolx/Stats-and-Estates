import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const MyButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.14,
          vertical: screenHeight * 0.018,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'DMSansMedium',
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
