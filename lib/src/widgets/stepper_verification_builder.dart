import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class VerificationStepperWidget extends StatefulWidget {
  const VerificationStepperWidget({super.key});

  @override
  State<VerificationStepperWidget> createState() =>
      _VerificationStepperWidgetState();
}

class _VerificationStepperWidgetState extends State<VerificationStepperWidget> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return EasyStepper(
      activeStep: activeStep,
      lineStyle: LineStyle(
        lineLength: width * 0.28,
        lineSpace: 0,
        lineType: LineType.normal,
        defaultLineColor: splashColor,
        finishedLineColor: buttonColor,
        lineThickness: 5,
      ),
      unreachedStepTextColor: splashColor,
      activeStepTextColor: Colors.black,
      finishedStepTextColor: Colors.black87,
      activeStepBackgroundColor: navigationBarColor,
      finishedStepBackgroundColor: navigationBarColor,
      unreachedStepBackgroundColor: Colors.transparent,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 20,
      showStepBorder: false,
      steps: [
        EasyStep(
          customStep: Icon(
            CupertinoIcons.person_crop_circle_badge_checkmark,
            size: width * 0.07,
          ),
          title: 'Basic',
        ),
        EasyStep(
          customStep: Icon(
            CupertinoIcons.checkmark_seal_fill,
            size: width * 0.07,
          ),
          title: 'Verified',
        ),
        EasyStep(
          customStep: Icon(
            CupertinoIcons.checkmark_shield_fill,
            size: width * 0.07,
          ),
          title: 'Trusted',
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index),
    );
  }
}
