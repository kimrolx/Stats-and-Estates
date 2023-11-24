import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/widgets/fields/user_info_builder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();

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

          nameController.text = '$firstName $lastName';
          emailController.text = userDoc['email'] ?? '';
          numberController.text = userDoc['number'] ?? '';
          addressController.text = userDoc['address'] ?? '';
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: splashColor,
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: buttonColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.25,
                    width: width,
                  ),
                  Image.asset(
                    'assets/images/property1/property1.jpg',
                    width: width,
                    height: height * 0.2,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    height: height * 0.4,
                    left: width * 0.4,
                    child: CircleAvatar(
                      radius: width * 0.1,
                      backgroundImage: const AssetImage(
                          'assets/images/signup_background.png'),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: userSheet,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 2,
                        offset: const Offset(0, 0.5),
                      ),
                    ],
                  ),
                  width: width * 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.035,
                      vertical: height * 0.04,
                    ),
                    child: Column(
                      children: [
                        MyUserInfoField(
                            controller: nameController, labelText: 'Name'),
                        Gap(height * 0.03),
                        MyUserInfoField(
                            controller: emailController, labelText: 'Email'),
                        Gap(height * 0.03),
                        MyUserInfoField(
                            controller: numberController,
                            labelText: 'Contact Number'),
                        Gap(height * 0.03),
                        MyUserInfoField(
                            controller: addressController,
                            labelText: 'Address'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
