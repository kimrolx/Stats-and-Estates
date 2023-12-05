import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/providers/listing_details_provider.dart';
import 'package:stats_and_estates/src/providers/listings_provider.dart';
import 'package:stats_and_estates/src/models/listing_details.dart';
import 'package:stats_and_estates/src/models/listings.dart';
import 'package:stats_and_estates/src/screens/listing_details_page.dart';
import 'package:stats_and_estates/src/widgets/favorites_container_builder.dart';

class FavoritesPage extends StatefulWidget {
  final int tab;
  const FavoritesPage({super.key, required this.tab});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isDeleteButtonVisible = false;

  List<ListingsContent> favoritesData = ListingsProvider.getListingsContent();
  List<ListingDetails> listingDetails =
      ListingDetailsProvider.getListingsDetails();

  void onDeletePressed(int index) {
    setState(() {
      favoritesData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              actions: <Widget>[
                //Show Delete Button
                IconButton(
                  onPressed: () {
                    setState(() {
                      isDeleteButtonVisible = !isDeleteButtonVisible;
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: width * 0.065,
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              expandedHeight: height * 0.125,
              floating: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  'My Favorites',
                  style: TextStyle(
                    fontFamily: 'BabasNeueRegular',
                    fontSize: width * 0.1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: width * 0.035,
                right: width * 0.035,
                bottom: height * 0.035,
              ),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: height * 0.035,
                crossAxisSpacing: width * 0.035,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      ListingsContent selectedListing = favoritesData[index];
                      ListingDetails selectedDetails = listingDetails[index];

                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => ListingDetailsPage(
                            listingsContent: selectedListing,
                            listingDetails: selectedDetails,
                          ),
                        ),
                      );
                    },
                    child: MyFavoritesContainer(
                      listingsContent: favoritesData[index],
                      isDeleteButtonVisible: isDeleteButtonVisible,
                      onDeletePressed: () {
                        onDeletePressed(index);
                      },
                    ),
                  );
                },
                childCount: favoritesData.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
