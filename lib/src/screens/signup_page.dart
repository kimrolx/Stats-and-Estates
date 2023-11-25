import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/screens/main_page.dart';
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  //Sign up user
  Future<void> signUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    if (passwordConfirmed()) {
      try {
        // Authenticate User
        await authService.createUserWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );

        // Add User details to database.
        addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailController.text.trim(),
          _numberController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
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
  }

  Future addUserDetails(
      String firstName, String lastName, String email, String number) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'number': number,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
      return false;
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
                          controller: _firstNameController,
                          labelText: 'First Name',
                        ),
                        SizedBox(height: height * 0.03),
                        MyTextField(
                          controller: _lastNameController,
                          labelText: 'Last Name',
                        ),
                        SizedBox(height: height * 0.03),
                        MyTextField(
                          controller: _emailController,
                          labelText: 'Email Address',
                        ),
                        SizedBox(height: height * 0.03),
                        MyTextField(
                          controller: _numberController,
                          labelText: 'Phone Number',
                        ),
                        SizedBox(height: height * 0.03),
                        PasswordField(controller: _passwordController),
                        SizedBox(height: height * 0.03),
                        ConfirmPasswordField(
                            controller: _confirmPasswordController),
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
