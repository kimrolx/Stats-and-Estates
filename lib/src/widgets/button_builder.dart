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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.14,
          vertical: height * 0.019,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'DMSansBold',
          fontSize: width * 0.038,
        ),
      ),
    );
  }
}
