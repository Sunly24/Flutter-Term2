import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/model/ride/ride.dart';
import 'package:blablacar/model/ride_pref/ride_pref.dart';
import 'package:blablacar/model/user/user.dart';
import 'package:blablacar/repository/ride_repository.dart';
import 'package:blablacar/service/rides_service.dart';

class MockRideRepository extends RideRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation:
          Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime(2025, 3, 3, 5, 30),
      arrivalDateTime: DateTime(2025, 3, 3, 7, 30),
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
      departureLocation:
          Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime(2025, 3, 3, 8),
      arrivalDateTime: DateTime(2025, 3, 3, 10),
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
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime(2025, 3, 3, 5),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
        arrivalDateTime: DateTime(2025, 3, 3, 8),
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
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime(2025, 3, 3, 8),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
        arrivalDateTime: DateTime(2025, 3, 3, 10),
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
        departureLocation:
            Location(name: 'Battambang', country: Country.cambodia),
        departureDate: DateTime(2025, 3, 3, 5),
        arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
        arrivalDateTime: DateTime(2025, 3, 3, 8),
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
    return _rides;
  }
}
