import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stats_and_estates/src/constants/colors.dart';
import 'package:stats_and_estates/src/models/listings.dart';

class MyMapListingsContainer extends StatelessWidget {
  final ListingsContent listingsContent;
  const MyMapListingsContainer({super.key, required this.listingsContent});

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
      width: width * 0.025,
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
      child: Padding(
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
                  fontSize: width * 0.045,
                  color: Colors.white,
                ),
              ),
            ),
            Text(listingsContent.address, style: commonTextStyle),
            Text(listingsContent.cost, style: commonTextStyle),
            Gap(height * 0.015),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2.0),
                child: Text(
                  'Contact',
                  style: TextStyle(
                    fontFamily: 'DMSansRegular',
                    fontSize: width * 0.035,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
