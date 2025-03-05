import 'package:blablacar/screens/ride_pref/widgets/ride_pref_input_tile.dart';
import 'package:blablacar/utils/date_time_util.dart';
import 'package:blablacar/widgets/inputs/bla_location_picker.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/actions/bla_button.dart';
//import 'date_picker.dart';
import '../../../theme/theme.dart';
import '../../../utils/animations_util.dart';
//import 'seat_number_spinner.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  // Inject LocationsService

  /// Callback triggered when form is submitted with valid data
  final Function(RidePref ridePref) onSubmit;

  const RidePrefForm({
    super.key,
    required this.initRidePref,
    required this.onSubmit,
  });

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  /// Selected departure location
  Location? departure;

  /// Selected arrival location
  Location? arrival;

  /// Selected travel date
  late DateTime departureDate;

  /// Number of passengers
  late int requestedSeats;

  /// Form is valid when both locations are selected
  bool get _isFormValid => departure != null && arrival != null;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  /// Initialize form fields from provided RidePref or defaults
  void _initializeFormData() {
    if (widget.initRidePref != null) {
      RidePref current = widget.initRidePref!;
      departure = current.departure;
      arrival = current.arrival;
      departureDate = current.departureDate;
      requestedSeats = current.requestedSeats;
    } else {
      // If no given preferences, we select default ones :
      departure = null; // User shall select the departure
      departureDate = DateTime.now(); // Now  by default
      arrival = null; // User shall select the arrival
      requestedSeats = 1; // 1 seat book by default
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onDeparturePressed() async {
    // 1- Select a location
    Location? selectedLocation = await Navigator.of(context)
        .push<Location>(AnimationUtils.createBottomToTopRoute(BlaLocationPicker(
      initLocation: departure,
    )));

    // 2- Update the from if needed
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    // 1- Select a location
    Location? selectedLocation = await Navigator.of(context)
        .push<Location>(AnimationUtils.createBottomToTopRoute(BlaLocationPicker(
      initLocation: arrival,
    )));

    // 2- Update the from if needed
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void _handleDateSelected(DateTime date) async {
    setState(() {
      departureDate = date;
    });
  }

  void _handleSeatsChanged(int seats) {
    setState(() {
      requestedSeats = seats;
    });
  }

  /// Creates and submits a RidePref object when form is valid
  void onSubmit() {
    // 1- Check input validity
    bool hasDeparture = departure != null;
    bool hasArrival = arrival != null;
    bool isValid = hasDeparture && hasArrival;

    if (isValid) {
      // 2 - Create a  new preference
      RidePref newPreference = RidePref(
          departure: departure!,
          departureDate: departureDate,
          arrival: arrival!,
          requestedSeats: requestedSeats);

      // 3 - Callback withg the new preference
      widget.onSubmit(newPreference);
    }
  }

  /// Switches departure and arrival locations if both are set
  void onSwappingLocationPressed() {
    setState(() {
      // We switch only if both departure and arrivate are defined
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
            child: Column(
              children: [
                // Departure location field
                RidePrefInputTile(
                    title: departureLabel,
                    onPressed: onDeparturePressed,
                    leftIcon: Icons.radio_button_checked_outlined,
                    isPlaceHolder: showDeparturePLaceHolder,
                    rightIcon: switchVisible ? Icons.swap_vert : null,
                    onRightIconPressed:
                        switchVisible ? onSwappingLocationPressed : null),
                // Arrival location field
                const BlaDivider(),
                // Arrival location field
                RidePrefInputTile(
                  title: arrivalLabel,
                  onPressed: onArrivalPressed,
                  leftIcon: Icons.radio_button_checked_outlined,
                  isPlaceHolder: showArrivalPLaceHolder,
                ),
                const BlaDivider(),
                // Date selection field
                RidePrefInputTile(
                  title: dateLabel,
                  onPressed: () {},
                  leftIcon: Icons.calendar_month_outlined,
                ),
                const BlaDivider(),
                // Passenger count field
                RidePrefInputTile(
                  title: numberLabel,
                  onPressed: () {},
                  leftIcon: Icons.person_outline,
                ),
              ],
            ),
          ),
          // Submit button
          SizedBox(
            width: double.infinity,
            child: BlaButton(
              label: 'Search',
              onPressed: onSubmit,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(BlaSpacings.radius),
                  bottomRight: Radius.circular(BlaSpacings.radius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // /// Builds the date selection field
  // Widget _buildDateField() {
  //   return InkWell(
  //     onTap: () async {
  //       final result = await Navigator.of(context).push<DateTime>(
  //         AnimationUtils.createBottomToTopRoute(
  //           DateSelectionScreen(initialDate: departureDate),
  //         ),
  //       );
  //       if (result != null) {
  //         _handleDateSelected(result);
  //       }
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               Icon(
  //                 Icons.calendar_month_outlined,
  //                 color: BlaColors.neutralLight,
  //                 size: 24,
  //               ),
  //               const SizedBox(width: BlaSpacings.m),
  //               DateDisplay(
  //                 date: departureDate,
  //                 isToday: departureDate.year == DateTime.now().year &&
  //                     departureDate.month == DateTime.now().month &&
  //                     departureDate.day == DateTime.now().day,
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  /// Builds the passenger count selection field
  // Widget _buildPassengerField() {
  //   return InkWell(
  //     onTap: () async {
  //       final result = await Navigator.of(context).push<int>(
  //         AnimationUtils.createBottomToTopRoute(
  //           SeatSelectionScreen(initialSeats: requestedSeats),
  //         ),
  //       );
  //       if (result != null) {
  //         _handleSeatsChanged(result);
  //       }
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               Icon(
  //                 Icons.person_outline,
  //                 color: BlaColors.neutralLight,
  //                 size: 24,
  //               ),
  //               const SizedBox(width: BlaSpacings.m),
  //               Text(
  //                 '$requestedSeats',
  //                 style: BlaTextStyles.body.copyWith(
  //                   color: BlaColors.textNormal,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
