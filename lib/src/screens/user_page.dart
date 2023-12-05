import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/providers/current_index_provider.dart';
import 'package:stats_and_estates/src/screens/higher_verification_page.dart';
import 'package:stats_and_estates/src/screens/landing_page.dart';
import 'package:stats_and_estates/src/screens/notifications_page.dart';
import 'package:stats_and_estates/src/screens/payment_methods_page.dart';
import 'package:stats_and_estates/src/screens/profile_page.dart';
import 'package:stats_and_estates/src/services/authentication/auth_service.dart';
import 'package:stats_and_estates/src/widgets/stepper_verification_builder.dart';
import 'package:stats_and_estates/src/widgets/user_components_builder.dart';

class UserPage extends StatefulWidget {
  final int tab;
  const UserPage({super.key, required this.tab});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  //Controllers
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        //Retrieve User Email
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: user.email)
                .limit(1)
                .get();

        //Check if the query returned any documents
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot<Map<String, dynamic>> userDoc =
              querySnapshot.docs.first;

          //Update the controller values with the retrieved data
          String firstName = userDoc['first name'] ?? '';
          String lastName = userDoc['last name'] ?? '';

          setState(() {
            nameController.text = '$firstName $lastName';
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Logout User
  void logout() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final currentIndexProvider =
        Provider.of<CurrentIndexProvider>(context, listen: false);

    currentIndexProvider.updateIndex(0);

    authService.signOut();

    Navigator.of(context, rootNavigator: true).pushReplacement(
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.025),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                              nameController.text,
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
                const Center(
                  child: VerificationStepperWidget(),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: splashColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => const HigherVerificationPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Verify Now!',
                      style: TextStyle(
                        fontFamily: 'DMSansMedium',
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                ),
                Gap(height * 0.015),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'DMSansBold',
                    fontSize: width * 0.045,
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
                Gap(height * 0.01),
                InkWell(
                  // TODO Payment Methods Route
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => const PaymentMethodsPage(),
                      ),
                    );
                  },
                  child: const MyUserComponent(
                    text: 'Payment Methods',
                    icon: CupertinoIcons.creditcard_fill,
                  ),
                ),
                Gap(height * 0.01),
                Divider(
                  color: userSheet,
                ),
                Gap(height * 0.03),
                Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'DMSansBold',
                    fontSize: width * 0.045,
                  ),
                ),
                Gap(height * 0.015),
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationsPage(),
                      ),
                    );
                  },
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
                InkWell(
                  // TODO User Feedback Route
                  onTap: () {},
                  child: const MyUserComponent(
                    text: 'User Support',
                    icon: CupertinoIcons.person_circle_fill,
                  ),
                ),
                Gap(height * 0.01),
                Divider(
                  color: userSheet,
                ),
                Gap(height * 0.03),
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
        ),
      ),
    );
  }
}
