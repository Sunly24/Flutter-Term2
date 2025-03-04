import 'package:blablacar/model/ride/ride.dart';

enum SortType { departureDate, price }

class RideSortType {
  final SortType sortType;

  RideSortType(this.sortType);

  List<Ride> sort(List<Ride> rides) {
    switch (sortType) {
      case SortType.departureDate:
        rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
        break;
      case SortType.price:
        rides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
        break;
    }
    return rides;
  }
}
