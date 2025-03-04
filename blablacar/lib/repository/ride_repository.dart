import 'package:blablacar/model/ride/ride.dart';
import 'package:blablacar/model/ride_pref/ride_pref.dart';
import 'package:blablacar/service/rides_service.dart';

abstract class RideRepository {
  /// Retrieves all available rides
  List<Ride> getRides(RidePref preferences, RidesFilter? filter);
}
