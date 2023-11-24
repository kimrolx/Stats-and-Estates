import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/data/listing_details_provider.dart';
import 'package:stats_and_estates/src/data/listings_provider.dart';
import 'package:stats_and_estates/src/models/listing_details.dart';
import 'package:stats_and_estates/src/models/listings.dart';
import 'package:stats_and_estates/src/screens/listing_details_page.dart';
import 'package:stats_and_estates/src/widgets/favorites_container_builder.dart';
import 'package:stats_and_estates/src/widgets/navigationbar_builder.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<ListingsContent> favoritesData = ListingsProvider.getListingsContent();
    List<ListingDetails> listingDetails =
        ListingDetailsProvider.getListingsDetails();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Favorites',
            style: TextStyle(
              fontFamily: 'BabasNeueRegular',
              fontSize: width * 0.15,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.035, vertical: height * 0.01),
        child: MasonryGridView.builder(
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: height * 0.035,
          crossAxisSpacing: width * 0.035,
          itemCount: 4,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              ListingsContent selectedListing = favoritesData[index];
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
            child: MyFavoritesContainer(listingsContent: favoritesData[index]),
          ),
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
