import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

Widget statistics2Builder(
    double width, double height, IconData icon, String text, String text2) {
  return Container(
    decoration: BoxDecoration(
      color: favoritesContainer,
      borderRadius: BorderRadius.circular(30),
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
        horizontal: width * 0.05,
        vertical: height * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: width * 0.125,
          ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'DMSansBold',
              fontSize: width * 0.04,
              color: Colors.white,
            ),
          ),
          Gap(width * 0.025),
          Text(
            text2,
            style: TextStyle(
              fontFamily: 'DMSansBold',
              fontSize: width * 0.1,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
