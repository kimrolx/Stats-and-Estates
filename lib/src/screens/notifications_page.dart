import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/services/notifications/notification_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isPushNotifSwitched = false;
  bool isScheduleNotifSwitched = false;
  bool isDNDSwitched = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          'Notifications & Sounds',
          style: TextStyle(
            fontFamily: 'DMSansBold',
            fontSize: width * 0.065,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.025,
                  vertical: height * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: splashColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(CupertinoIcons.bell),
                              Gap(width * 0.01),
                              Text(
                                'Push Notifications',
                                style: TextStyle(
                                  fontFamily: 'DMSansMedium',
                                  fontSize: width * 0.04,
                                ),
                              ),
                              const Spacer(),
                              FlutterSwitch(
                                width: width * 0.12,
                                height: height * 0.03,
                                activeColor: navigationBarColor,
                                inactiveColor: backgroundColor,
                                value: isPushNotifSwitched,
                                onToggle: (val) async {
                                  // Update the widget state synchronously inside setState
                                  setState(() {
                                    isPushNotifSwitched = val;
                                  });
                                  if (isPushNotifSwitched) {
                                    await NotificationService
                                        .initializeNotification();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(height * 0.015),
                    Text(
                      'Notification Preferences',
                      style: TextStyle(
                        fontFamily: 'DMSansBold',
                        fontSize: width * 0.04,
                      ),
                    ),
                    Gap(height * 0.015),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: splashColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(CupertinoIcons.calendar),
                              Gap(width * 0.01),
                              Text(
                                'Schedule Push Notifications',
                                style: TextStyle(
                                  fontFamily: 'DMSansMedium',
                                  fontSize: width * 0.04,
                                ),
                              ),
                              const Spacer(),
                              FlutterSwitch(
                                width: width * 0.12,
                                height: height * 0.03,
                                activeColor: navigationBarColor,
                                inactiveColor: backgroundColor,
                                value: isScheduleNotifSwitched,
                                onToggle: (val) {
                                  setState(() {
                                    isScheduleNotifSwitched = val;
                                  });
                                },
                              ),
                            ],
                          ),
                          Gap(height * 0.015),
                          Visibility(
                            visible: isScheduleNotifSwitched,
                            child: Row(
                              children: [
                                Text(
                                  'Start',
                                  style: TextStyle(
                                    fontFamily: 'DMSansMedium',
                                    fontSize: width * 0.04,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '12:00 AM',
                                  style: TextStyle(
                                    fontFamily: 'DMSansMedium',
                                    fontSize: width * 0.04,
                                  ),
                                ),
                                const Icon(
                                  CupertinoIcons.forward,
                                ),
                              ],
                            ),
                          ),
                          Gap(height * 0.005),
                          Visibility(
                            visible: isScheduleNotifSwitched,
                            child: Row(
                              children: [
                                Text(
                                  'End',
                                  style: TextStyle(
                                    fontFamily: 'DMSansMedium',
                                    fontSize: width * 0.04,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '8:00 AM',
                                  style: TextStyle(
                                    fontFamily: 'DMSansMedium',
                                    fontSize: width * 0.04,
                                  ),
                                ),
                                const Icon(
                                  CupertinoIcons.forward,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(CupertinoIcons.moon),
                              Gap(width * 0.01),
                              Text(
                                'Do not Disturb',
                                style: TextStyle(
                                  fontFamily: 'DMSansMedium',
                                  fontSize: width * 0.04,
                                ),
                              ),
                              const Spacer(),
                              FlutterSwitch(
                                width: width * 0.12,
                                height: height * 0.03,
                                activeColor: navigationBarColor,
                                inactiveColor: backgroundColor,
                                value: isDNDSwitched,
                                onToggle: (val) {
                                  setState(() {
                                    isDNDSwitched = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
