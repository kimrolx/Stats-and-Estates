import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

Widget statistics1Builder(
    double width, double height, IconData icon, String text, String text2) {
  return Container(
    width: width * 0.42,
    decoration: BoxDecoration(
      color: favoritesContainer,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(1),
          blurRadius: 2,
          offset: const Offset(0, 0.1),
        ),
      ],
      borderRadius: BorderRadius.circular(35),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.035,
        vertical: height * 0.02,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: width * 0.075,
              ),
              Gap(width * 0.01),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.035,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            text2,
            style: TextStyle(
              fontFamily: 'DMSansBold',
              fontSize: width * 0.115,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
