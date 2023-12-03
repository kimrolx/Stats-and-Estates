import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/screens/main_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user != null) {
            if (user.emailVerified) {
              // Email is verified, navigate to MainPage
              return const MainPage();
            } else {
              // Email is not verified yet, display the verification message
              return _buildVerificationPage(user, width, height);
            }
          }
        }

        // Loading state or no user, you can show a loading spinner or handle it accordingly
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildVerificationPage(User user, double width, double height) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Verification',
            style: TextStyle(
              fontFamily: 'DMSansRegular',
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                child: Column(
                  children: [
                    Gap(height * 0.1),
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: forgotPasswordContainer,
                      child: SvgPicture.asset(
                        'assets/icons/mail.svg',
                        width: width * 0.3,
                      ),
                    ),
                    Gap(height * 0.025),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Text(
                        'An email has been sent to ${user.email}, please verify your account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'DMSansMedium',
                          fontSize: width * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
