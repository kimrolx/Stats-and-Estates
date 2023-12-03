import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

Widget statistics3Builder(
  double width,
  double height,
) {
  return Container(
    height: height * 0.31,
    width: width * 0.9,
    decoration: BoxDecoration(
      color: favoritesContainer,
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(1),
          blurRadius: 2,
          offset: const Offset(0, 0.1),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.075,
        vertical: height * 0.02,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_shield,
                    color: Colors.white,
                    size: width * 0.075,
                  ),
                  Gap(width * 0.01),
                  Text(
                    'Crime Rate',
                    style: TextStyle(
                      fontFamily: 'DMSansBold',
                      fontSize: width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '40%',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.12,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.person_2,
                    color: Colors.white,
                    size: width * 0.075,
                  ),
                  Gap(width * 0.01),
                  Text(
                    'Population',
                    style: TextStyle(
                      fontFamily: 'DMSansBold',
                      fontSize: width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '896',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.12,
                  color: Colors.white,
                ),
              ),
              Text(
                'Sources',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.025,
                  color: Colors.white,
                ),
              ),
              Text(
                'https://www.legitsources.com',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.015,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gap(width * 0.035),
          VerticalDivider(
            width: width * 0.015,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Colors.white,
          ),
          Gap(width * 0.035),
          Image.asset('assets/images/Statistic.png'),
        ],
      ),
    ),
  );
}
