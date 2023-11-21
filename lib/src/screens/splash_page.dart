import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/services/authentication/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToAuthGate();
  }

  _navigateToAuthGate() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthGate(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/Stats & Estates Logo.svg',
                  width: width * 0.4, // Adjust the factor as needed
                  height: height * 0.2, // Adjust the factor as needed
                ),
                Text(
                  'Stats & Estates',
                  style: TextStyle(
                    fontFamily: 'CDBold',
                    fontSize: width * 0.07,
                    fontWeight: FontWeight.w600,
                    color: textLogoColor,
                  ),
                ),
                Text(
                  'Unlocking your ideal home, informed and easy.',
                  style: TextStyle(
                    fontFamily: 'DMSansRegular',
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.04,
                    color: textLogoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
