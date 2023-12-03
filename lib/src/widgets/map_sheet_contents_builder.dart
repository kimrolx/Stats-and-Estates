import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/models/listing_details.dart';
import 'package:stats_and_estates/src/models/listings.dart';
import 'package:stats_and_estates/src/providers/listing_details_provider.dart';
import 'package:stats_and_estates/src/providers/listings_provider.dart';
import 'package:stats_and_estates/src/screens/listing_details_page.dart';
import 'package:stats_and_estates/src/widgets/map_listings_builder.dart';
import 'statistics1_builder.dart';
import 'statistics2_builder.dart';
import 'statistics3_builder.dart';
import 'statistics4_builder.dart';
import 'statistics5_builder.dart';

class MyBottomSheetContents extends StatefulWidget {
  const MyBottomSheetContents({super.key});

  @override
  State<MyBottomSheetContents> createState() => _MyBottomSheetContentsState();
}

class _MyBottomSheetContentsState extends State<MyBottomSheetContents> {
  bool isSwitched = false;

  List<ListingsContent> favoritesData = ListingsProvider.getListingsContent();
  List<ListingDetails> listingDetails =
      ListingDetailsProvider.getListingsDetails();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.4,
            maxChildSize: 0.7,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: splashColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.only(
                left: width * 0.05,
                top: height * 0.02,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: [
                  Text(
                    'Barangay chuchuchu',
                    style: TextStyle(
                      fontFamily: 'DMSansBold',
                      fontSize: width * 0.055,
                    ),
                  ),
                  Text(
                    'Yellow Zone',
                    style: TextStyle(
                      fontFamily: 'DMSansRegular',
                      fontSize: width * 0.035,
                    ),
                  ),
                  Gap(height * 0.025),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Area Statistics',
                          style: TextStyle(
                            fontFamily: 'DMSansMedium',
                            fontSize: width * 0.04,
                          ),
                        ),
                        FlutterSwitch(
                          width: width * 0.12,
                          height: height * 0.03,
                          activeColor: navigationBarColor,
                          inactiveColor: backgroundColor,
                          value: isSwitched,
                          onToggle: (val) {
                            setState(() {
                              isSwitched = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(height * 0.005),
                  Visibility(
                    visible: isSwitched,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(right: width * 0.04),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: width * 0.01,
                          top: height * 0.01,
                          bottom: height * 0.01,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: height * 0.275,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      statistics1Builder(
                                        width,
                                        height,
                                        CupertinoIcons.exclamationmark_shield,
                                        'Crime Rate',
                                        '40%',
                                      ),
                                      Gap(width * 0.035),
                                      statistics1Builder(
                                        width,
                                        height,
                                        Icons.monitor_heart_outlined,
                                        'Mortality Rate',
                                        '51%',
                                      ),
                                    ],
                                  ),
                                  Gap(height * 0.015),
                                  statistics2Builder(
                                    width,
                                    height,
                                    CupertinoIcons.location_fill,
                                    'Travel Efficiency Rate',
                                    '67%',
                                  ),
                                ],
                              ),
                            ),
                            Gap(width * 0.05),
                            statistics3Builder(width, height),
                            Gap(width * 0.05),
                            statistics4Builder(width, height),
                            Gap(width * 0.05),
                            statistics5Builder(width, height),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(height * 0.015),
                  Text(
                    'Listings Available',
                    style: TextStyle(
                      fontFamily: 'DMSansMedium',
                      fontSize: width * 0.04,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.02,
                        right: width * 0.05,
                        bottom: height * 0.02),
                    child: MasonryGridView.builder(
                      mainAxisSpacing: height * 0.035,
                      crossAxisSpacing: width * 0.035,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: favoritesData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            ListingsContent selectedListing =
                                favoritesData[index];
                            ListingDetails selectedDetails =
                                listingDetails[index];

                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (context) => ListingDetailsPage(
                                  listingsContent: selectedListing,
                                  listingDetails: selectedDetails,
                                ),
                              ),
                            );
                          },
                          child: MyMapListingsContainer(
                            listingsContent: favoritesData[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
