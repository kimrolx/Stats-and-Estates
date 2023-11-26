import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyUserComponent extends StatelessWidget {
  final String text;
  final IconData icon;
  const MyUserComponent({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: splashColor,
          foregroundColor: buttonColor,
          radius: width * 0.06,
          child: Icon(
            icon,
            size: width * 0.07,
          ),
        ),
        Gap(width * 0.035),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'DMSansMedium',
            fontSize: width * 0.04,
          ),
        ),
        const Spacer(),
        const Icon(CupertinoIcons.forward, color: Colors.black),
      ],
    );
  }
}
