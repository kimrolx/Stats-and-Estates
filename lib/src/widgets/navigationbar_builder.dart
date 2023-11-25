import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const MyNavigationBar(
      {super.key, required this.onTap, required this.currentIndex});

  static const List<IconData> selectedIcons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.heart_fill,
    CupertinoIcons.map_fill,
    CupertinoIcons.mail_solid,
    CupertinoIcons.person_fill,
  ];

  static const List<IconData> unselectedIcons = [
    CupertinoIcons.house,
    CupertinoIcons.heart,
    CupertinoIcons.map,
    CupertinoIcons.mail,
    CupertinoIcons.person,
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    IconData buildNavigationBarItemIcon(int currentIndex, int index) {
      return currentIndex == index
          ? selectedIcons[index]
          : unselectedIcons[index];
    }

    GButton buildNavigationBarItem(int currentIndex, int index, String label) {
      return GButton(
        icon: buildNavigationBarItemIcon(currentIndex, index),
        text: label,
      );
    }

    List<GButton> buildBottomNavigationBarItems(int currentIndex) {
      return [
        buildNavigationBarItem(currentIndex, 0, 'Home'),
        buildNavigationBarItem(currentIndex, 1, 'Favorites'),
        buildNavigationBarItem(currentIndex, 2, 'Map'),
        buildNavigationBarItem(currentIndex, 3, 'Chat'),
        buildNavigationBarItem(currentIndex, 4, 'User'),
      ];
    }

    return Container(
      color: navigationBarColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.01,
        ),
        child: GNav(
          backgroundColor: navigationBarColor,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: buttonColor,
          gap: width * 0.015,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.02,
            vertical: height * 0.01,
          ),
          tabs: buildBottomNavigationBarItems(currentIndex),
          onTabChange: onTap,
        ),
      ),
    );
  }
}
