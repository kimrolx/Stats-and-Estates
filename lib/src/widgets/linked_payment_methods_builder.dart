import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyLinkedMethods extends StatelessWidget {
  final String logo;
  final String account;
  const MyLinkedMethods({super.key, required this.logo, required this.account});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
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
      child: Row(
        children: [
          Image.asset(logo),
          Gap(width * 0.025),
          Text(
            account,
            style: TextStyle(
              fontFamily: 'DMSansMedium',
              fontSize: width * 0.045,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
