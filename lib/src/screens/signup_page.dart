import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/screens/homepage.dart';
import 'package:stats_and_estates/src/widgets/back_button_builder.dart';
import 'package:stats_and_estates/src/widgets/background_image.dart';
import 'package:stats_and_estates/src/widgets/button_builder.dart';
import 'package:stats_and_estates/src/widgets/fields/confirm_password_field.dart';
import 'package:stats_and_estates/src/widgets/fields/password_field.dart';
import 'package:stats_and_estates/src/widgets/fields/text_field_builder.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  //Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        const BackgroundImage(imagePath: 'assets/images/signup_background.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Positioned(
                    top: height * 0.03,
                    left: width * 0.06,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const MyBackButton(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                      vertical: height * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.03),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: 'DMSansBold',
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height * 0.05),
                        MyTextField(
                          controller: nameController,
                          labelText: 'Name',
                        ),
                        SizedBox(height: height * 0.03),
                        MyTextField(
                          controller: emailController,
                          labelText: 'Email Address',
                        ),
                        SizedBox(height: height * 0.03),
                        MyTextField(
                          controller: numberController,
                          labelText: 'Phone Number',
                        ),
                        SizedBox(height: height * 0.03),
                        PasswordField(controller: passwordController),
                        SizedBox(height: height * 0.03),
                        ConfirmPasswordField(
                            controller: confirmPasswordController),
                        SizedBox(height: height * 0.04),
                        Center(
                          child: CustomButton(
                            text: 'Sign Up',
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
