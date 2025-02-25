import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'package:intl/intl.dart';

class RideScreen extends StatelessWidget {
  final String departure;
  final String arrival;
  final DateTime date;
  final int seats;

  const RideScreen({
    super.key,
    required this.departure,
    required this.arrival,
    required this.date,
    required this.seats,
  });

  String _formatDate() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == tomorrow.day) {
      return 'Tomorrow';
    }

    return DateFormat('EEE, MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ride Search Results',
          style: BlaTextStyles.body.copyWith(
            color: BlaColors.textNormal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(BlaSpacings.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: $departure',
            ),
            Text(
              'To: $arrival',
            ),
            Row(
              children: [
                Text(
                  'Date: ',
                ),
                Text(
                  _formatDate(),
                ),
              ],
            ),
            Text(
              'Passengers: $seats ${seats > 1 ? 'passengers' : 'passenger'}',
            ),
          ],
        ),
      ),
    );
  }
}
