import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            children: [
              Image.asset(
                'assets/images/Stats & Estates.png',
                width: 150,
                height: 150,
              ),
              Text(
                'Stats & Estates',
                style: TextStyle(
                  fontFamily: 'CDBold',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: imageColor,
                ),
              ),
              Text(
                'Unlocking your ideal home, informed and easy.',
                style: TextStyle(
                  fontFamily: 'DMSansRegular',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: imageColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
