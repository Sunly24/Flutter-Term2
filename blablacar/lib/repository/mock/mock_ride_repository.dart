import 'package:blablacar/dummy_data/dummy_data.dart';
import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/model/ride/ride.dart';
import 'package:blablacar/model/ride_pref/ride_pref.dart';
import 'package:blablacar/model/user/user.dart';
import 'package:blablacar/repository/ride_repository.dart';
import 'package:blablacar/service/rides_service.dart';
import 'package:blablacar/utils/date_time_util.dart';

class MockRideRepository extends RideRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation: cambodialocations[2],
      arrivalLocation: cambodialocations[1],
      departureDate: DateTime.now().copyWith(hour: 5, minute: 30),
      arrivalDateTime: DateTime.now().copyWith(hour: 8, minute: 30),
      pricePerSeat: 10,
      driver: User(
        firstName: 'Kannika',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 4,
      acceptPets: false,
    ),
    Ride(
      departureLocation: cambodialocations[2],
      arrivalLocation: cambodialocations[1],
      departureDate: DateTime.now().copyWith(hour: 8),
      arrivalDateTime: DateTime.now().copyWith(hour: 10),
      pricePerSeat: 10,
      driver: User(
        firstName: 'Chaylim',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 0,
      acceptPets: false,
    ),
    Ride(
        departureLocation: cambodialocations[2],
        arrivalLocation: cambodialocations[1],
        departureDate: DateTime.now().copyWith(hour: 5),
        arrivalDateTime: DateTime.now().copyWith(hour: 8),
        driver: User(
          firstName: 'Mengtech',
          lastName: '',
          email: '',
          phone: '',
          profilePicture: '',
          verifiedProfile: true,
        ),
        availableSeats: 1,
        pricePerSeat: 10,
        acceptPets: false),
    Ride(
        departureLocation: cambodialocations[2],
        arrivalLocation: cambodialocations[1],
        departureDate: DateTime.now().copyWith(hour: 8),
        arrivalDateTime: DateTime.now().copyWith(hour: 10),
        driver: User(
          firstName: 'Limhao',
          lastName: '',
          email: '',
          phone: '',
          profilePicture: '',
          verifiedProfile: true,
        ),
        availableSeats: 2,
        pricePerSeat: 10,
        acceptPets: true),
    Ride(
        departureLocation: cambodialocations[2],
        arrivalLocation: cambodialocations[1],
        departureDate: DateTime.now().copyWith(hour: 5),
        arrivalDateTime: DateTime.now().copyWith(hour: 8),
        driver: User(
          firstName: 'Sovanda',
          lastName: '',
          email: '',
          phone: '',
          profilePicture: '',
          verifiedProfile: true,
        ),
        availableSeats: 1,
        pricePerSeat: 10,
        acceptPets: false),
  ];

  @override
  List<Ride> getRides(RidePref preferences, RidesFilter? filter) {
    List<Ride> filteredRides = _rides
        .where((ride) =>
            ride.departureLocation == preferences.departure &&
            ride.arrivalLocation == preferences.arrival &&
            isSameDate(ride.departureDate, preferences.departureDate) &&
            ride.availableSeats >= preferences.requestedSeats)
        .toList();

    if (filter != null) {
      filteredRides = filteredRides
          .where((ride) => ride.acceptPets == filter.acceptPets)
          .toList();
    }

    return filteredRides;
  }
}
