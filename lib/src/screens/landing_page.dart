import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/screens/forgot_password_page.dart';
import 'package:stats_and_estates/src/screens/signup_page.dart';
import 'package:stats_and_estates/src/screens/main_page.dart';
import 'package:stats_and_estates/src/services/authentication/auth_service.dart';
import 'package:stats_and_estates/src/widgets/background_image_builder.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Login user
  void login() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      Navigator.of(context).pushReplacement(
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        const MyBackgroundImage(
          imagePath: 'assets/images/landing_page_background.png',
        ),
        GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.1,
                        right: width * 0.1,
                        top: height * 0.1,
                        bottom: height * 0.03,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'DMSansBold',
                                fontSize: width * 0.1,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Gap(height * 0.04),
                            Text(
                              'Making Relocation Informed and Easier.',
                              style: TextStyle(
                                fontFamily: 'DMSansBold',
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            MyTextField(
                              controller: _emailController,
                              labelText: 'Email Address',
                            ),
                            SizedBox(height: height * 0.03),
                            PasswordField(controller: _passwordController),
                            Gap(height * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const ForgotPasswordPage(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.fastOutSlowIn;
                                          return SlideTransition(
                                            position: Tween(
                                                    begin: begin, end: end)
                                                .chain(CurveTween(curve: curve))
                                                .animate(
                                                  CurvedAnimation(
                                                    parent: animation,
                                                    curve: const Interval(
                                                        0.0, 0.5),
                                                  ),
                                                ),
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 400),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontFamily: 'DMSansRegular',
                                      fontSize: width * 0.035,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(height * 0.005),
                            Center(
                              child: MyButton(
                                onPressed: login,
                                text: 'Login',
                              ),
                            ),
                            SizedBox(height: height * 0.25),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MyButton(
                                text: 'New User? Create Account',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUpPage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
