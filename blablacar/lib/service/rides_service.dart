import 'package:blablacar/model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePref preferences) {
    //  print(availableRides);

    // For now, just a test
    return availableRides
        .where((ride) =>
            ride.departureLocation == preferences.departure &&
            ride.arrivalLocation == preferences.arrival)
        .toList();
  }
}

void main() {
  for (var ride in RidesService.availableRides) {
    print('From: ${ride.departureLocation}');
    print('To: ${ride.arrivalLocation}');
    print('Date: ${ride.departureDate}');
    print('Price: ${ride.pricePerSeat}€');
    print('Driver: ${ride.driver}');
    print('---------------------');
  }
}
