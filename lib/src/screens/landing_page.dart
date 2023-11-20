import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/screens/homepage.dart';
import 'package:stats_and_estates/src/screens/signup_page.dart';
import 'package:stats_and_estates/src/widgets/background_image.dart';
import 'package:stats_and_estates/src/widgets/button_builder.dart';
import 'package:stats_and_estates/src/widgets/fields/text_field_builder.dart';
import 'package:stats_and_estates/src/widgets/fields/password_field.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        const BackgroundImage(
            imagePath: 'assets/images/landing_page_background.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                      vertical: height * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'DMSansBold',
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        MyTextField(
                          controller: emailController,
                          labelText: 'Email Address',
                        ),
                        SizedBox(height: height * 0.03),
                        PasswordField(controller: passwordController),
                        SizedBox(height: height * 0.04),
                        Center(
                          child: CustomButton(
                            text: 'Login',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                            backgroundColor: buttonColor,
                          ),
                        ),
                        SizedBox(height: height * 0.25),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomButton(
                            text: 'New User? Create Account',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            backgroundColor: buttonColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}