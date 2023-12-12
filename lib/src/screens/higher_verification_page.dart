import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/services/notifications/notification_service.dart';
import 'package:stats_and_estates/src/widgets/stepper_verification_builder.dart';

class HigherVerificationPage extends StatelessWidget {
  const HigherVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Widget levelRowBuilder(IconData icon, String text) => Row(
          children: [
            Icon(
              icon,
              size: width * 0.07,
              color: Colors.black,
            ),
            Gap(width * 0.025),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'DMSansBold',
                fontSize: width * 0.04,
              ),
            ),
          ],
        );

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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.03,
          ),
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
              Gap(height * 0.010),
              const VerificationStepperWidget(),
              levelRowBuilder(
                CupertinoIcons.person_crop_circle_badge_checkmark,
                'Basic Level',
              ),
              Gap(height * 0.015),
              Text(
                '- Assigned to all newly registered accounts; requires email verification only.',
                style: TextStyle(
                  fontFamily: 'DMSansMeidum',
                  fontSize: width * 0.035,
                ),
              ),
              Gap(height * 0.04),
              levelRowBuilder(
                CupertinoIcons.checkmark_seal_fill,
                'Verified Level',
              ),
              Gap(height * 0.015),
              Text(
                '- A higher verification level, achievable through phone number verification, using OTP or a one-time-pin.',
                style: TextStyle(
                  fontFamily: 'DMSansMeidum',
                  fontSize: width * 0.035,
                ),
              ),
              Gap(height * 0.04),
              levelRowBuilder(
                CupertinoIcons.checkmark_shield_fill,
                'Trusted Level',
              ),
              Gap(height * 0.015),
              Text(
                '- The highest level of verification. Achievable by submitting your selected legal IDs. ',
                style: TextStyle(
                  fontFamily: 'DMSansMeidum',
                  fontSize: width * 0.035,
                ),
              ),
              Gap(height * 0.04),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        NotificationService.showNotification(
                          title: 'Congratulations!',
                          body:
                              'You have successfully enhanced your verification level!',
                        );
                      },
                      child: Text(
                        'Start Verification Process',
                        style: TextStyle(
                          fontFamily: 'DMSansMedium',
                          fontSize: width * 0.045,
                        ),
                      ),
                    ),
                    Gap(height * 0.01),
                    Text(
                      'Basic Level requires an active email.',
                      style: TextStyle(
                          fontFamily: 'DMSansRegular',
                          fontSize: width * 0.035,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      'Verified Level requires an active phone number.',
                      style: TextStyle(
                          fontFamily: 'DMSansRegular',
                          fontSize: width * 0.035,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      'Truted Level requires the legal ID to not be expired.',
                      style: TextStyle(
                          fontFamily: 'DMSansRegular',
                          fontSize: width * 0.035,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
