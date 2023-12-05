import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/models/listings.dart';

class MyFavoritesContainer extends StatelessWidget {
  final ListingsContent listingsContent;
  final bool isDeleteButtonVisible;
  final Function() onDeletePressed;

  const MyFavoritesContainer(
      {super.key,
      required this.listingsContent,
      required this.isDeleteButtonVisible,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final commonTextStyle = TextStyle(
      fontFamily: 'DMSansRegular',
      fontSize: width * 0.035,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );

    return Container(
      width: width * 0.05,
      decoration: BoxDecoration(
        color: favoritesContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(1),
            blurRadius: 2,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.025, vertical: height * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.01),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: height * 0.2,
                      child: Image.asset(
                        listingsContent.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    listingsContent.name,
                    style: TextStyle(
                      fontFamily: 'BabasNeueRegular',
                      fontSize: width * 0.055,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(listingsContent.address, style: commonTextStyle),
                Text(listingsContent.cost, style: commonTextStyle),
                Gap(height * 0.015),
                Center(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width * 0.285,
                          height: height * 0.043,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                fontFamily: 'DMSansMedium',
                                fontSize: width * 0.04,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const NoteDialogWidget(),
                            );
                          },
                          icon: const Icon(
                            Icons.edit_note,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Delete Button
          Positioned(
            top: -10,
            right: -10,
            child: Visibility(
              visible: isDeleteButtonVisible,
              child: IconButton(
                onPressed: () {
                  onDeletePressed();
                },
                icon: Icon(
                  CupertinoIcons.minus_circle_fill,
                  size: width * 0.07,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoteDialogWidget extends StatelessWidget {
  const NoteDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(
          color: splashColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Note',
              style: TextStyle(
                fontFamily: 'DMSansMedium',
                fontSize: width * 0.05,
                color: Colors.black,
              ),
            ),
            Gap(height * 0.015),
            TextFormField(
              minLines: 2,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter Note Here',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Gap(height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.025,
                      vertical: height * 0.015,
                    ),
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
