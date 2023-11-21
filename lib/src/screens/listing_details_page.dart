import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
                horizontal: width * 0.08,
                vertical: height * 0.03,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.08,
                      vertical: height * 0.03,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.listingsContent.name,
                            style: TextStyle(
                              fontFamily: 'DMSansBold',
                              fontSize: width * 0.065,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            widget.listingsContent.address,
                            style: TextStyle(
                              fontFamily: 'DMSansRegular',
                              fontSize: width * 0.04,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            widget.listingDetails.landmark,
                            style: TextStyle(
                              fontFamily: 'DMSansRegular',
                              fontSize: width * 0.04,
                            ),
                          ),
                          const Gap(2),
                          Text(
                            'Minimum of ${widget.listingDetails.contract}',
                            style: TextStyle(
                              fontFamily: 'DMSansBold',
                              fontSize: width * 0.04,
                            ),
                          ),
                          const Gap(20),
                          // TODO
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Gap(10),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.black,
                              ),
                              const Gap(10),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
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
