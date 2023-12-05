import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/services/authentication/auth_service.dart';
import 'package:stats_and_estates/src/widgets/fields/user_info_builder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditable = true;

  //Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData().then((_) {
      setState(() {
        isEditable = true;
      });
    });
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
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: splashColor,
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              // Toggle the editable state
              setState(() {
                isEditable = !isEditable;
              });
              if (isEditable) {
                // If in edit mode, save the changes
                String userId = FirebaseAuth.instance.currentUser!.uid;
                String newEmail = emailController.text;
                String newNumber = numberController.text;
                String newAddress = addressController.text;

                final authService =
                    Provider.of<AuthService>(context, listen: false);

                // Always consider email for updates
                bool emailEdited = newEmail !=
                    FirebaseAuth.instance.currentUser!.email?.trim();

                // Check if any other edits have been made
                bool otherEdits = emailEdited ||
                    newNumber != numberController.text ||
                    newAddress != addressController.text;

                // Update the user profile with the new address
                if (otherEdits) {
                  await authService.updateProfile(
                    userId,
                    newEmail: newEmail,
                    newNumber: newNumber,
                    newAddress: newAddress,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                    ),
                  );
                }

                // Notify the user that the changes are saved
              }
            },
            child: isEditable
                ? Text(
                    'Edit',
                    style: TextStyle(
                      fontFamily: 'DMSansRegular',
                      fontSize: width * 0.04,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'DMSansRegular',
                      fontSize: width * 0.04,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: backgroundColor,
        ),
        elevation: 5.0,
        backgroundColor: buttonColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                            isReadOnly: true,
                            controller: nameController,
                            labelText: 'Name'),
                        Gap(height * 0.03),
                        MyUserInfoField(
                            isReadOnly: isEditable,
                            controller: emailController,
                            labelText: 'Email'),
                        Gap(height * 0.03),
                        MyUserInfoField(
                            isReadOnly: isEditable,
                            controller: numberController,
                            labelText: 'Contact Number'),
                        Gap(height * 0.03),
                        MyUserInfoField(
                            isReadOnly: isEditable,
                            controller: addressController,
                            labelText: 'Address'),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(height * 0.035),
              Text(
                'Delete Account',
                style: TextStyle(
                  fontFamily: 'DMSansMedium',
                  fontSize: width * 0.045,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
