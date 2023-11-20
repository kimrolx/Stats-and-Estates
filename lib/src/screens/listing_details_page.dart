import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/data/listing_details_provider.dart';
import 'package:stats_and_estates/src/models/listing_details.dart';
import 'package:stats_and_estates/src/models/listings.dart';
import 'package:stats_and_estates/src/widgets/back_button_builder.dart';
import 'package:stats_and_estates/src/widgets/carousel_builder.dart';
import 'package:stats_and_estates/src/widgets/favorites_builder.dart';

class ListingDetailsPage extends StatefulWidget {
  final ListingsContent listingsContent;
  final ListingDetails listingDetails;
  const ListingDetailsPage(
      {super.key, required this.listingsContent, required this.listingDetails});

  @override
  State<ListingDetailsPage> createState() => _ListingDetailsPageState();
}

class _ListingDetailsPageState extends State<ListingDetailsPage> {
  //Listing Details
  List<ListingDetails> listingDetails =
      ListingDetailsProvider.getListingsDetails();

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
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: Colors.transparent,
            ),
            MyCarousel(imagePaths: images),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
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
                    color: themeBackground,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
