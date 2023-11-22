import 'package:stats_and_estates/src/models/listings.dart';

class ListingsProvider {
  static List<ListingsContent> getListingsContent() {
    return [
      ListingsContent(
        image: 'assets/images/property1/property1.jpg',
        name: 'Eva Bayanihan Apartment',
        address: 'Bayanihan Village, Quiot, Cebu City',
        cost: 'PHP 3500/month',
      ),
      ListingsContent(
        image: 'assets/images/property2/property2.jpeg',
        name: 'Bed Spacer (Girls)',
        address: 'Carlock Street Cebu City, near C. Padilla',
        cost: 'PHP 3000/month',
      ),
      ListingsContent(
        image: 'assets/images/property3/property3.jpg',
        name: 'Rooms for Rent',
        address: 'Pool Bankal, near Anthurium Inn ',
        cost: 'PHP 2500/month',
      ),
      ListingsContent(
        image: 'assets/images/property4/property4.jpg',
        name: 'Accomodations for Rent',
        address: 'IT Park',
        cost: 'PHP 4000/month',
      ),
    ];
  }
}
