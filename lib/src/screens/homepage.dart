import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/data/listing_details_provider.dart';
import 'package:stats_and_estates/src/data/listings_provider.dart';
import 'package:stats_and_estates/src/models/listing_details.dart';
import 'package:stats_and_estates/src/models/listings.dart';
import 'package:stats_and_estates/src/screens/listing_details_page.dart';
import 'package:stats_and_estates/src/widgets/listing_builder.dart';
import 'package:stats_and_estates/src/widgets/navigationbar_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Controller
  final searchController = TextEditingController();

  //Listings
  List<ListingsContent> listingsContent = ListingsProvider.getListingsContent();
  List<ListingDetails> listingDetails =
      ListingDetailsProvider.getListingsDetails();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.14,
              decoration: BoxDecoration(
                color: navigationBarColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(width * 0.1),
                  bottomRight: Radius.circular(width * 0.1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.9,
                      height: height * 0.06,
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: splashColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            fontFamily: 'DMSansRegular',
                            color: Colors.white,
                            fontSize: width * 0.045,
                          ),
                          suffixIcon: Container(
                            width: width * 0.15,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: buttonColor,
                            ),
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.search,
                                size: width * 0.06,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  //TODO Search
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listingsContent.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ListingsContent selectedListing = listingsContent[index];
                      ListingDetails selectedDetails = listingDetails[index];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListingDetailsPage(
                            listingsContent: selectedListing,
                            listingDetails: selectedDetails,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.01),
                      child: MyListing(listingsContent: listingsContent[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: navigationBarColor,
        foregroundColor: Colors.white,
        tooltip: 'View Map',
        onPressed: () {
          //TODO View Map
        },
        child: Icon(
          CupertinoIcons.map_pin_ellipse,
          size: width * 0.08,
        ),
      ),
    );
  }
}
