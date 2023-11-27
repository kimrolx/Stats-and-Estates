import 'package:flutter/material.dart';

class MyAmenities extends StatelessWidget {
  final String image;

  const MyAmenities({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(image),
    );
  }
}
