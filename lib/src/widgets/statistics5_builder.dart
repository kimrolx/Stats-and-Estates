import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

Widget statistics5Builder(
  double width,
  double height,
) {
  Widget buildRow(
          {required String text,
          required String text2,
          required String text3}) =>
      Container(
        color: favoritesContainer,
        child: Row(
          children: [
            Column(
              children: [
                Icon(
                  CupertinoIcons.bus,
                  color: Colors.white,
                  size: width * 0.07,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'DMSansMedium',
                    fontSize: width * 0.04,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Gap(width * 0.02),
            Column(
              children: [
                Icon(
                  CupertinoIcons.bus,
                  color: Colors.white,
                  size: width * 0.07,
                ),
                Text(
                  text2,
                  style: TextStyle(
                    fontFamily: 'DMSansMedium',
                    fontSize: width * 0.04,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Gap(width * 0.02),
            Column(
              children: [
                Icon(
                  CupertinoIcons.bus,
                  color: Colors.white,
                  size: width * 0.07,
                ),
                Text(
                  text3,
                  style: TextStyle(
                    fontFamily: 'DMSansMedium',
                    fontSize: width * 0.04,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  return Container(
    height: height * 0.34,
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
        horizontal: width * 0.04,
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
                    CupertinoIcons.location_fill,
                    color: Colors.white,
                    size: width * 0.075,
                  ),
                  Gap(width * 0.01),
                  Text(
                    'Travel Efficiency Rate',
                    style: TextStyle(
                      fontFamily: 'DMSansBold',
                      fontSize: width * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '67%',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.18,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.bus,
                    color: Colors.white,
                    size: width * 0.075,
                  ),
                  Gap(width * 0.01),
                  SizedBox(
                    width: width * 0.4,
                    child: Text(
                      'Number of Accessible Transport',
                      style: TextStyle(
                        fontFamily: 'DMSansBold',
                        fontSize: width * 0.035,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '9',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.12,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Gap(width * 0.01),
          VerticalDivider(
            width: width * 0.015,
            thickness: 2,
            indent: 10,
            endIndent: 25,
            color: Colors.white,
          ),
          Gap(width * 0.005),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildRow(text: '12D', text2: '12G', text3: '12A'),
              buildRow(text: '12C', text2: '09F', text3: '12L'),
              buildRow(text: '10F', text2: '10G', text3: '09G'),
            ],
          ),
        ],
      ),
    ),
  );
}
