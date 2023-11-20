import 'package:stats_and_estates/src/models/listings.dart';

class ListingsProvider {
  static List<ListingsContent> getListingsContent() {
    return [
      ListingsContent(
        image: 'assets/images/property1.jpg',
        name: 'Eva Bayanihan Apartment',
        address: 'Bayanihan Village, Quiot, Cebu City',
        cost: 'PHP 3500/month',
      ),
      ListingsContent(
        image: 'assets/images/property2.jpg',
        name: 'Bed Spacer (Girls)',
        address: 'Carlock Street Cebu City, near C. Padilla',
        cost: 'PHP 3000/month',
      ),
      ListingsContent(
        image: 'assets/images/property3.jpg',
        name: 'Rooms for Rent',
        address: 'Pool Bankal, near Anthurium Inn ',
        cost: 'PHP 2500/month',
      ),
      // Add more listings as needed
    ];
  }
}
