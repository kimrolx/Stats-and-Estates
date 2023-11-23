import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/screens/homepage.dart';
import 'package:stats_and_estates/src/services/authentication/auth_service.dart';
import 'package:stats_and_estates/src/widgets/back_button_builder.dart';
import 'package:stats_and_estates/src/widgets/background_image_builder.dart';
import 'package:stats_and_estates/src/widgets/button_builder.dart';
import 'package:stats_and_estates/src/widgets/fields/confirm_password_field.dart';
import 'package:stats_and_estates/src/widgets/fields/password_field.dart';
import 'package:stats_and_estates/src/widgets/fields/text_field_builder.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Sign up user
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.createUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        const MyBackgroundImage(
            imagePath: 'assets/images/signup_background.png'),
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
                          controller: firstNameController,
                          labelText: 'First Name',
                        ),
                        SizedBox(height: height * 0.03),
                        MyTextField(
                          controller: lastNameController,
                          labelText: 'Last Name',
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
                          child: MyButton(
                            onPressed: signUp,
                            text: 'Sign up',
                          ),
                        ),
                        Gap(height * 0.07),
                        Center(
                          child: Text(
                            'By signing up, you agree to our',
                            style: TextStyle(
                              fontFamily: 'DMSansBold',
                              fontSize: width * 0.035,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Terms of Use and Privacy Policy',
                            style: TextStyle(
                                fontFamily: 'DMSansBold',
                                fontSize: width * 0.035,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: width * 0.005),
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
