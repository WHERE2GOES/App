import 'package:flutter/material.dart';
import 'package:navigation/model/route_guidance_item_prop.dart';
import 'package:navigation/screen/navigation_map_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: _TestApp(),
    ),
  );
}

class _TestApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestAppState();
}

class _TestAppState extends State<_TestApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationMapScreen(
        mapWidget: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.green,
        ),
        tutorialStep: null,
        totalTravelTime: Duration(hours: 35),
        nearbyPlacePopup: null,
        destinationName: "숙명여대",
        routeGuidanceItems: [
          (
            description: "올리브영에서 직진",
            routeGuidanceType: RouteGuidanceType.straight,
            distance: 150,
          ),
          (
            description: "올리브영에서 우회전",
            routeGuidanceType: RouteGuidanceType.turnRight,
            distance: 150,
          ),
          (
            description: "올리브영 방면으로 횡단보도 건너기",
            routeGuidanceType: RouteGuidanceType.crosswalk,
            distance: 150,
          ),
          (
            description: "올리브영에서 우회전",
            routeGuidanceType: RouteGuidanceType.turnRight,
            distance: 150,
          ),
        ],
        onTimerClicked: () {},
        onBackButtonClicked: () {},
        onMenuButtonClicked: () {},
        onEmergencyButtonClicked: () {},
        onGoToCurrentLocationButtonClicked: () {},
      ),
    );
  }
}
