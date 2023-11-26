import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/models/nav_model.dart';
import 'package:stats_and_estates/src/providers/current_index_provider.dart';
import 'package:stats_and_estates/src/screens/chat_page.dart';
import 'package:stats_and_estates/src/screens/favorites_page.dart';
import 'package:stats_and_estates/src/screens/home_page.dart';
import 'package:stats_and_estates/src/screens/map_page.dart';
import 'package:stats_and_estates/src/screens/user_page.dart';
import 'package:stats_and_estates/src/widgets/navigationbar_builder.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //Global Keys
  final homeNavKey = GlobalKey<NavigatorState>();
  final favoritesNavKey = GlobalKey<NavigatorState>();
  final mapNavKey = GlobalKey<NavigatorState>();
  final chatNavKey = GlobalKey<NavigatorState>();
  final userNavKey = GlobalKey<NavigatorState>();
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const HomePage(
          tab: 0,
        ),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const FavoritesPage(
          tab: 1,
        ),
        navKey: favoritesNavKey,
      ),
      NavModel(
        page: const MapPage(tab: 2),
        navKey: mapNavKey,
      ),
      NavModel(
        page: const ChatPage(tab: 3),
        navKey: chatNavKey,
      ),
      NavModel(
        page: const UserPage(tab: 4),
        navKey: userNavKey,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentIndexProvider>(
      builder: (context, currentIndexProvider, _) {
        return PopScope(
          canPop: items[currentIndexProvider.currentIndex]
                  .navKey
                  .currentState
                  ?.canPop() ??
              false,
          child: Stack(
            children: [
              Scaffold(
                body: IndexedStack(
                  index: currentIndexProvider.currentIndex,
                  children: items
                      .map((page) => Navigator(
                            key: page.navKey,
                            onGenerateInitialRoutes: (navigator, initialRoute) {
                              return [
                                MaterialPageRoute(
                                    builder: (context) => page.page),
                              ];
                            },
                          ))
                      .toList(),
                ),
                backgroundColor: backgroundColor,
                bottomNavigationBar: MyNavigationBar(
                  currentIndex: currentIndexProvider.currentIndex,
                  onTap: (index) {
                    if (index == currentIndexProvider.currentIndex) {
                      items[index]
                          .navKey
                          .currentState
                          ?.popUntil((route) => route.isFirst);
                    } else {
                      setState(() {
                        currentIndexProvider.updateIndex(index);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
