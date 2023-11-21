import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyBackgroundImage extends StatelessWidget {
  final String imagePath;

  const MyBackgroundImage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
