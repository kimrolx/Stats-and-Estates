import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stats_and_estates/src/models/listings.dart';

class MyListing extends StatelessWidget {
  final ListingsContent listingsContent;
  const MyListing({super.key, required this.listingsContent});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final commonTextStyle = TextStyle(
      fontFamily: 'DMSansRegular',
      fontSize: width * 0.04,
      fontWeight: FontWeight.w500,
    );

    return Container(
      width: width * 0.670,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(listingsContent.name, style: commonTextStyle),
                Text(listingsContent.cost, style: commonTextStyle),
              ],
            ),
            Row(
              children: [
                const Icon(CupertinoIcons.location_solid),
                Text(
                  listingsContent.address,
                  style: TextStyle(
                    fontFamily: 'DMSansRegular',
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
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
