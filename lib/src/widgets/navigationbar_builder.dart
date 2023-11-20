import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<IconData> selectedIcons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.bookmark_fill,
    CupertinoIcons.chat_bubble_fill,
    CupertinoIcons.person_fill,
  ];

  List<IconData> unselectedIcons = [
    CupertinoIcons.house,
    CupertinoIcons.bookmark,
    CupertinoIcons.chat_bubble,
    CupertinoIcons.person,
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(width * 0.1),
        topRight: Radius.circular(width * 0.1),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: navigationBarColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        iconSize: width * 0.065,
        currentIndex: currentIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon:
                Icon(currentIndex == 0 ? selectedIcons[0] : unselectedIcons[0]),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(currentIndex == 1 ? selectedIcons[1] : unselectedIcons[1]),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(currentIndex == 2 ? selectedIcons[2] : unselectedIcons[2]),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(currentIndex == 3 ? selectedIcons[3] : unselectedIcons[3]),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
