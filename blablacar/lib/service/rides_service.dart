import 'package:blablacar/model/ride_pref/ride_pref.dart';
import 'package:blablacar/repository/ride_repository.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';
import '../model/ride/ride_sort.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static RidesService? _instance;

  final RideRepository rideRepository;

  RidesService._internal(this.rideRepository);

  static void initialize(RideRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
        "RidesService is not initialized. Call initialize() first.",
      );
    }
    return _instance!;
  }

  static List<Ride> availableRides = fakeRides; // TODO for now fake data
  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(
      RidePref preferences, RidesFilter? filter, RideSortType? sortType) {
    return instance.rideRepository.getRides(preferences, filter, sortType);
  }
}

class RidesFilter {
  final bool acceptPets;

  RidesFilter({required this.acceptPets});
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
