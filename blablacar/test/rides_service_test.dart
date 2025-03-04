import 'package:blablacar/model/ride_pref/ride_pref.dart';
import 'package:blablacar/repository/mock/mock_ride_repository.dart';
import 'package:blablacar/service/rides_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blablacar/dummy_data/dummy_data.dart' as dummy_data;

void main() {
  RidesService.initialize(MockRideRepository());

  RidePref preferences = RidePref(
    departure: dummy_data.cambodialocations[2],
    arrival: dummy_data.cambodialocations[1],
    departureDate: DateTime.now(),
    requestedSeats: 1,
  );

  RidesFilter filter = RidesFilter(acceptPets: true);

  var result1 = RidesService.getRidesFor(preferences, null);
  var result2 = RidesService.getRidesFor(preferences, filter);

  test('Battambang to Siem Reap, today, 1 passenger', () {
    expect(result1.length, 4);
    if (result1.length == 4) {
      print('For today, 1 passenger, rides found:' + result1.length.toString());
    }
  });

  test('Battambang to Siem Reap, today, 1 passenger, accept pets', () {
    expect(result2.length, 1);
    if (result2.length == 1) {
      print('For today, 1 passenger, accept pets, rides found:' +
          result2.length.toString());
    }
  });
}
