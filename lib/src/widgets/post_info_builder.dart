import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyLandlordPost extends StatelessWidget {
  final String image;
  final String name;
  final String date;
  const MyLandlordPost(
      {super.key, required this.image, required this.name, required this.date});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.8,
      height: height * 0.06,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: buttonColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: width * 0.045,
            ),
            Gap(width * 0.015),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.035,
                color: Colors.black,
              ),
            ),
            Gap(width * 0.03),
            Text(
              date,
              style: TextStyle(
                  fontFamily: 'DMSansRegular',
                  fontSize: width * 0.035,
                  color: Colors.black54),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.mail,
              size: width * 0.07,
              color: buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
