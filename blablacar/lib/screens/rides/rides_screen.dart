import 'package:blablacar/screens/rides/widgets/ride_pref_modal.dart';
import 'package:blablacar/service/ride_prefs_service.dart';
import 'package:blablacar/utils/animations_util.dart';
import 'package:flutter/material.dart';
import 'package:blablacar/screens/rides/widgets/ride_pref_bar.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RidePref currentPreference = RidePrefService.instance.currentPreference!;

  List<Ride> get matchingRides => RidesService.instance.rideRepository
      .getRides(currentPreference, null, null);

  void onBackPressed() {
    Navigator.of(context).pop(); //  Back to the previous view
  }

  void onPreferencePressed() async {
    // Navigate to the Ride Preference Modal
    final newPreference = await Navigator.of(context).push<RidePref>(
      AnimationUtils.createBottomToTopRoute(
        RidePrefModal(
          initPreference: currentPreference,
        ),
      ),
    );

    // After pop, get the new current preference from the modal
    if (newPreference != null) {
      setState(() {
        currentPreference = newPreference;
        RidePrefService.instance.setCurrentPreference(newPreference);
      });
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed),

          Expanded(
            child: ListView.builder(
              itemCount: matchingRides.length,
              itemBuilder: (ctx, index) => RideTile(
                ride: matchingRides[index],
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
