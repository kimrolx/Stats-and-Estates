import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/screens/landing_page.dart';
import 'package:stats_and_estates/src/screens/profile_page.dart';
import 'package:stats_and_estates/src/services/authentication/auth_service.dart';
import 'package:stats_and_estates/src/widgets/navigationbar_builder.dart';
import 'package:stats_and_estates/src/widgets/user_components_builder.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //Logout User
  void logout() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LandingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.035,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.035),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const ProfilePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.fastOutSlowIn;
                          return SlideTransition(
                            position: Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve))
                                .animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: const Interval(0.0, 0.55),
                                  ),
                                ),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: splashColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.035,
                      vertical: height * 0.02,
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: width * 0.08,
                        backgroundImage:
                            //TODO Profile Image
                            const AssetImage(
                                'assets/images/landing_page_background.png'),
                      ),
                      Gap(width * 0.035),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sheian Neil Mary Intes',
                            style: TextStyle(
                              fontFamily: 'DMSansBold',
                              fontSize: width * 0.045,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Manage Profile',
                            style: TextStyle(
                              fontFamily: 'DMSansRegular',
                              fontSize: width * 0.035,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(CupertinoIcons.forward, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.05,
              ),
            ),
            Gap(height * 0.015),
            InkWell(
              // TODO Landlord Route
              onTap: () {},
              child: const MyUserComponent(
                text: 'Become a Landlord',
                icon: CupertinoIcons.person_fill,
              ),
            ),
            Gap(height * 0.01),
            Divider(
              color: userSheet,
            ),
            Gap(height * 0.055),
            Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.05,
              ),
            ),
            Gap(height * 0.015),
            InkWell(
              // TODO Notifications Route
              onTap: () {},
              child: const MyUserComponent(
                text: 'Notifications',
                icon: CupertinoIcons.bell_fill,
              ),
            ),
            Gap(height * 0.01),
            Divider(
              color: userSheet,
            ),
            Gap(height * 0.01),
            InkWell(
              // TODO Feedback Route
              onTap: () {},
              child: const MyUserComponent(
                text: 'Feedback',
                icon: CupertinoIcons.envelope_fill,
              ),
            ),
            Gap(height * 0.01),
            Divider(
              color: userSheet,
            ),
            Gap(height * 0.01),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: Size(width * 0.7, height * 0.05),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontFamily: 'DMSansBold',
                    fontSize: width * 0.045,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: navigationBarColor,
        foregroundColor: Colors.white,
        tooltip: 'View Map',
        onPressed: () {
          //TODO View Map
        },
        child: Icon(
          CupertinoIcons.map_pin_ellipse,
          size: width * 0.08,
        ),
      ),
    );
  }
}
