import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/providers/current_index_provider.dart';
import 'package:stats_and_estates/src/screens/landing_page.dart';
import 'package:stats_and_estates/src/services/authentication/auth_service.dart';
import 'package:stats_and_estates/src/widgets/fields/user_info_builder.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditable = false;

  //Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();

  String currentUser = FirebaseAuth.instance.currentUser?.uid ?? "";

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    getUserDetails(currentUser);
  }

  Future<void> getUserDetails(String userID) async {
    try {
      Map<String, dynamic>? userData =
          await _authService.getUserDetails(userID);

      if (userData != null) {
        String firstName = userData['first name'] ?? '';
        String lastName = userData['last name'] ?? '';
        String fullName = '$firstName $lastName';

        setState(() {
          nameController.text = fullName.trim();
          emailController.text = userData['email'] ?? '';
          numberController.text = userData['number'] ?? '';
          addressController.text = userData['address'] ?? '';
        });
      }
    } catch (e) {
      debugPrint('Error getting user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: splashColor,
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                setState(() {
                  isEditable = !isEditable;
                });
                if (isEditable) {
                  String newEmail = emailController.text;
                  String newNumber = numberController.text;
                  String newAddress = addressController.text;

                  final authService =
                      Provider.of<AuthService>(context, listen: false);

                  await authService.updateFirestoreUserDetails(
                    currentUser,
                    newEmail,
                    newNumber,
                    newAddress,
                  );

                  await authService.updateFromFirebaseAuth(newEmail);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully!'),
                    ),
                  );
                }
              },
              child: isEditable
                  ? Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: 'DMSansRegular',
                        fontSize: width * 0.04,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Edit',
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
                              isReadOnly: !isEditable,
                              controller: emailController,
                              labelText: 'Email'),
                          Gap(height * 0.03),
                          MyUserInfoField(
                              isReadOnly: !isEditable,
                              controller: numberController,
                              labelText: 'Contact Number'),
                          Gap(height * 0.03),
                          MyUserInfoField(
                              isReadOnly: !isEditable,
                              controller: addressController,
                              labelText: 'Address'),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(height * 0.015),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ConfirmDeleteDialog(),
                    );
                  },
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.045,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmDeleteDialog extends StatefulWidget {
  const ConfirmDeleteDialog({super.key});

  @override
  State<ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<ConfirmDeleteDialog> {
  String currentUser = FirebaseAuth.instance.currentUser?.uid ?? "";

  //Delete User
  void deleteAccount() {
    final authService = Provider.of<AuthService>(context, listen: false);
    final currentIndexProvider =
        Provider.of<CurrentIndexProvider>(context, listen: false);

    currentIndexProvider.updateIndex(0);

    authService.deleteFirestoreUserDetails(currentUser);
    authService.deleteUserFromAuth();

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

    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(
          color: splashColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete your account?',
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.05,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(height * 0.02),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.045,
                    ),
                  ),
                ),
                Gap(height * 0.015),
                ElevatedButton(
                  onPressed: deleteAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.045,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
