import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/repository/locations_repository.dart';

import '../dummy_data/dummy_data.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static LocationsService? _instance;

  static const List<Location> availableLocations = fakeLocations;

  final LocationsRepository locationsRepository;

  LocationsService._internal(this.locationsRepository);

  static void initialize(LocationsRepository locationsRepository) {
    if (_instance == null) {
      _instance = LocationsService._internal(locationsRepository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  static LocationsService get instance {
    if (_instance == null) {
      throw Exception(
          "LocationsService is not initialized. Call init() first.");
    }
    return _instance!;
  }

  List<Location> getLocations() {
    return locationsRepository.getLocations();
  }
}
