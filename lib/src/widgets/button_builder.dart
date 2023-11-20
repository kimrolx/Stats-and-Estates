import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double screenWidth;
  final double screenHeight;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.screenWidth = 0.14,
    this.screenHeight = 0.018,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
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
