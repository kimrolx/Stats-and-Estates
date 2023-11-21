import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
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

    authService.logout();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.055,
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
                    //TODO Profile Routing
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
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: width * 0.08,
                        backgroundImage:
                            //TODO Profile Image
                            const AssetImage('assets/images/room.jpg'),
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
            Divider(
              color: Colors.white,
              thickness: width * 0.008,
            ),
            Gap(height * 0.04),
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
            Gap(height * 0.015),
            InkWell(
              // TODO Feedback Route
              onTap: () {},
              child: const MyUserComponent(
                text: 'Feedback',
                icon: CupertinoIcons.envelope_fill,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: Size(width * 0.7, height * 0.05),
                ),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontFamily: 'DMSansMedium',
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
