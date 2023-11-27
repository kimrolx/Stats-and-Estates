import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/models/listing_details.dart';
import 'package:stats_and_estates/src/models/listings.dart';
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
          MyCarousel(imagePaths: images),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.07,
              vertical: height * 0.045,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyBackButton(),
                MyFavoritesButton(
                  isBookMarked: isBookMarked,
                  onTap: () {
                    setState(() {
                      isBookMarked = !isBookMarked;
                    });
                  },
                ),
              ],
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
                    top: height * 0.025,
                    bottom: height * 0.08,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
            child: const MyLandlordPost(
              image: 'assets/images/signup_background.png',
              name: 'Kim Berame',
              date: 'November 17, 2023',
            ),
          ),
        ],
      ),
    );
  }
}
