import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/widgets/add_rental_form_builder.dart';
import 'package:stats_and_estates/src/widgets/map_sheet_contents_builder.dart';
import 'package:stats_and_estates/src/widgets/search_bar_builder.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool isSwitched = false;

  bool isLongPressed = false;

  //Controllers
  final searchController = TextEditingController();
  final nameController = TextEditingController();
  final barangayController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final provinceController = TextEditingController();
  final codeController = TextEditingController();
  final priceController = TextEditingController();

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
        floatingActionButton: Visibility(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'info_button',
                backgroundColor: navigationBarColor,
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const MyBottomSheetContents(),
                  );
                },
                child: Icon(
                  CupertinoIcons.info,
                  color: Colors.white,
                  size: width * 0.07,
                ),
              ),
              Gap(height * 0.02),
              //TODO
              Visibility(
                visible: isLongPressed,
                child: FloatingActionButton(
                  heroTag: 'add_button',
                  backgroundColor: navigationBarColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyRentalForm(
                          nameController: nameController,
                          barangayController: barangayController,
                          streetController: streetController,
                          cityController: cityController,
                          provinceController: provinceController,
                          codeController: codeController,
                          priceController: priceController,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: width * 0.07,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            GestureDetector(
              onLongPress: () {
                setState(() {
                  isLongPressed = !isLongPressed;
                });
              },
              child: InteractiveViewer(
                constrained: false,
                scaleEnabled: true,
                child: Center(
                  child: Image.asset(
                    'assets/images/map.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.02,
                right: width * 0.07,
                top: height * 0.01,
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        CupertinoIcons.back,
                        color: navigationBarColor,
                        size: width * 0.1,
                      ),
                    ),
                    Gap(width * 0.025),
                    Expanded(
                      child: MySearchBar(
                        controller: searchController,
                        labelText: 'Search',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
