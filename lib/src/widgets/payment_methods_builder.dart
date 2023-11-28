import 'package:flutter/material.dart';

class MyPaymentMethods extends StatelessWidget {
  final String logo;
  final double scale;
  const MyPaymentMethods({super.key, required this.logo, required this.scale});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.07,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.025,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Transform.scale(
        scale: scale,
        child: Image.asset(logo),
      ),
    );
  }
}
