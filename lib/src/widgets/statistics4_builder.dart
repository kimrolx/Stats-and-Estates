import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

Widget statistics4Builder(double width, double height) {
  return Container(
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
        horizontal: width * 0.045,
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
                    Icons.monitor_heart_outlined,
                    color: Colors.white,
                    size: width * 0.075,
                  ),
                  Gap(width * 0.02),
                  Text(
                    'Safety Score',
                    style: TextStyle(
                      fontFamily: 'DMSansBold',
                      fontSize: width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '51%',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.15,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Establishments',
                        style: TextStyle(
                          fontFamily: 'DMSansBold',
                          fontSize: width * 0.04,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '6',
                        style: TextStyle(
                          fontFamily: 'DMSansBold',
                          fontSize: width * 0.1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gap(width * 0.035),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Police Stations',
                        style: TextStyle(
                          fontFamily: 'DMSansBold',
                          fontSize: width * 0.04,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '2',
                        style: TextStyle(
                          fontFamily: 'DMSansBold',
                          fontSize: width * 0.1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
