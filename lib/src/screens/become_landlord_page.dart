import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/services/notifications/notification_service.dart';

class BecomeLandlordPage extends StatelessWidget {
  const BecomeLandlordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            size: width * 0.075,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: buttonColor,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Start Your Verification',
                style: TextStyle(
                  fontFamily: 'DMSansBold',
                  fontSize: width * 0.085,
                ),
              ),
            ),
            Gap(height * 0.02),
            SizedBox(
              width: width,
              child: Image.asset(
                'assets/images/landlord.png',
                fit: BoxFit.cover,
              ),
            ),
            Gap(height * 0.035),
            Center(
              child: Column(
                children: [
                  Text(
                    'To register as a landlord, you must:',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.05,
                    ),
                  ),
                  Gap(height * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• be Trusted Level',
                        style: TextStyle(
                          fontFamily: 'DMSansMeidum',
                          fontSize: width * 0.04,
                        ),
                      ),
                      Text(
                        '• submit a copy of your business permit',
                        style: TextStyle(
                          fontFamily: 'DMSansMeidum',
                          fontSize: width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(height * 0.035),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  NotificationService.showNotification(
                    title: 'Congratulations! You are now a landlord!',
                    body: 'Start adding your accommodation now!',
                  );
                },
                child: Text(
                  'Become a Landlord Now',
                  style: TextStyle(
                    fontFamily: 'DMSansMedium',
                    fontSize: width * 0.045,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
