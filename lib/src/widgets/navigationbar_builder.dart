import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/screens/homepage.dart';
import 'package:stats_and_estates/src/screens/user_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  static const List<IconData> selectedIcons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.bookmark_fill,
    CupertinoIcons.chat_bubble_fill,
    CupertinoIcons.person_fill,
  ];

  static const List<IconData> unselectedIcons = [
    CupertinoIcons.house,
    CupertinoIcons.bookmark,
    CupertinoIcons.chat_bubble,
    CupertinoIcons.person,
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(width * 0.1),
        topRight: Radius.circular(width * 0.1),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: navigationBarColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        iconSize: width * 0.065,
        currentIndex: currentIndex,
        onTap: (index) => _handleNavigation(context, currentIndex, index),
        items: _buildBottomNavigationBarItems(currentIndex),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int currentIndex, int index) {
    Provider.of<CurrentIndexProvider>(context, listen: false)
        .updateIndex(index);

    if (currentIndex != index) {
      switch (index) {
        case 0:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
        // case 1:
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => const FavoritesPage()),
        //   );
        //   break;
        // case 2:
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => const ChatPage()),
        //   );
        //   break;
        case 3:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserPage()),
          );
          break;
      }
    }
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      int currentIndex) {
    return [
      _buildNavigationBarItem(currentIndex, 0, 'Home'),
      _buildNavigationBarItem(currentIndex, 1, 'Favorites'),
      _buildNavigationBarItem(currentIndex, 2, 'Chat'),
      _buildNavigationBarItem(currentIndex, 3, 'User'),
    ];
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      int currentIndex, int index, String label) {
    return BottomNavigationBarItem(
      icon: Icon(currentIndex == index
          ? selectedIcons[index]
          : unselectedIcons[index]),
      label: label,
    );
  }
}

class CurrentIndexProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
