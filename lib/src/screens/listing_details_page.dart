import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/models/listing_details.dart';
import 'package:stats_and_estates/src/models/listings.dart';
import 'package:stats_and_estates/src/screens/chat_page.dart';
import 'package:stats_and_estates/src/screens/main_page.dart';
import 'package:stats_and_estates/src/widgets/amenities_builder.dart';
import 'package:stats_and_estates/src/widgets/back_button_builder.dart';
import 'package:stats_and_estates/src/widgets/carousel_builder.dart';
import 'package:stats_and_estates/src/widgets/favorite_button_builder.dart';
import 'package:stats_and_estates/src/widgets/post_info_builder.dart';

class ListingDetailsPage extends StatefulWidget {
  final ListingsContent listingsContent;
  final ListingDetails listingDetails;
  const ListingDetailsPage(
      {super.key, required this.listingsContent, required this.listingDetails});

  @override
  State<ListingDetailsPage> createState() => _ListingDetailsPageState();
}

class _ListingDetailsPageState extends State<ListingDetailsPage> {
  bool isBookMarked = false;

  bool isLongPressed = false;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<String> images = [
      widget.listingsContent.image,
      widget.listingDetails.image0,
      widget.listingDetails.image1,
      widget.listingDetails.image2,
      widget.listingDetails.image3,
      widget.listingDetails.image4,
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            color: Colors.transparent,
          ),
          GestureDetector(
            //TODO
            onLongPress: () {
              setState(() {
                isLongPressed = !isLongPressed;
              });
            },
            child: MyCarousel(imagePaths: images),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.07,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyBackButton(),
                  //TODO
                  isLongPressed
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const MenuDialog(),
                            );
                          },
                          child: Container(
                            width: width * 0.14,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: buttonColor,
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.ellipsis,
                                size: width * 0.07,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Visibility(
                          visible: !isLongPressed,
                          child: MyFavoritesButton(
                            isBookMarked: isBookMarked,
                            onTap: () {
                              setState(() {
                                isBookMarked = !isBookMarked;
                              });
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.5,
            left: 0,
            right: 0,
            child: SizedBox(
              height: height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.06,
                    right: width * 0.06,
                    top: height * 0.015,
                    bottom: height * 0.08,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TODO
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.015,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTapped = !isTapped;
                                });
                              },
                              child: isTapped
                                  ? Text(
                                      'Occupied',
                                      style: TextStyle(
                                        fontFamily: 'DMSansBold',
                                        fontSize: width * 0.035,
                                      ),
                                    )
                                  : Text(
                                      'Available',
                                      style: TextStyle(
                                        fontFamily: 'DMSansBold',
                                        fontSize: width * 0.035,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.listingsContent.name,
                            style: TextStyle(
                              fontFamily: 'DMSansBold',
                              fontSize: width * 0.065,
                            ),
                          ),
                        ),
                        Gap(height * 0.015),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.location_solid),
                            Text(
                              widget.listingsContent.address,
                              style: TextStyle(
                                fontFamily: 'DMSansRegular',
                                fontSize: width * 0.04,
                              ),
                            ),
                          ],
                        ),
                        Gap(height * 0.0025),
                        Text(
                          widget.listingDetails.landmark,
                          style: TextStyle(
                            fontFamily: 'DMSansRegular',
                            fontSize: width * 0.04,
                          ),
                        ),
                        Text(
                          'Minimum of ${widget.listingDetails.contract}',
                          style: TextStyle(
                            fontFamily: 'DMSansBold',
                            fontSize: width * 0.04,
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: images.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01,
                                  vertical: height * 0.005),
                              child: FullScreenWidget(
                                disposeLevel: DisposeLevel.Medium,
                                child: InteractiveViewer(
                                  child: MyAmenities(
                                    image: images[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: width * 0.05,
            right: width * 0.05,
            bottom: height * 0.01,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatPage(tab: 2),
                  ),
                );
              },
              child: const MyLandlordPost(
                image: 'assets/images/signup_background.png',
                name: 'Kim Berame',
                date: 'November 17, 2023',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TODO
class MenuDialog extends StatelessWidget {
  const MenuDialog({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Edit Listing',
                style: TextStyle(
                  fontFamily: 'DMSansMedium',
                  fontSize: width * 0.045,
                ),
              ),
            ),
            Gap(height * 0.015),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfirmDeleteDialog(),
                  ),
                );
              },
              child: Text(
                'Delete Listing',
                style: TextStyle(
                  fontFamily: 'DMSansMedium',
                  fontSize: width * 0.045,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO
class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.delete,
              size: width * 0.15,
            ),
            Gap(height * 0.01),
            Text(
              'Delete this accommodation listing?',
              style:
                  TextStyle(fontFamily: 'DMSansMedium', fontSize: width * 0.04),
            ),
            Gap(height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.035,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
