import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/widgets/navigationbar_builder.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.1,
            ),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: splashColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 2,
                    offset: const Offset(0, 0.5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.025,
                  vertical: height * 0.01,
                ),
                child: Row(
                  children: [
                    // TODO
                    CircleAvatar(
                        radius: width * 0.08,
                        backgroundImage:
                            const AssetImage('assets/images/room.jpg')),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sheian Neil Mary Intes',
                          style: TextStyle(
                            fontFamily: 'DMSansBold',
                            fontSize: width * 0.04,
                          ),
                        ),
                        Text(
                          'Manage Profile',
                          style: TextStyle(
                            fontFamily: 'DMSansRegular',
                            fontSize: width * 0.035,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width * 0.15),
                    const Icon(CupertinoIcons.forward),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
