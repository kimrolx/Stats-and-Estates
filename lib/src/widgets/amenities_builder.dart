import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class MyAmenities extends StatelessWidget {
  final String svgAssetPath;
  final String text;

  const MyAmenities(
      {super.key, required this.svgAssetPath, required this.text});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.84,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 2,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              svgAssetPath,
              width: width * 0.3,
            ),
            Gap(height * 0.015),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'DMSansRegular',
                fontSize: width * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
