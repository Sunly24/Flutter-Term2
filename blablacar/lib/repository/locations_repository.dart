import '../model/ride/locations.dart';

/// Repository interface for managing locations
abstract class LocationsRepository {
  /// Retrieves all available locations
  List<Location> getLocations();
}
