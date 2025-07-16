import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:navigation/screens/navigation_map_screen.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  InAppWebViewController? mapController;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return switch (settings.name) {
              '/' => _buildNavigationMapScreen(),
              _ => throw Exception("Invalid route"),
            };
          },
        );
      },
    );
  }

  Widget _buildNavigationMapScreen() {
    return NavigationMapScreen(
      mapWidget: InAppWebView(onWebViewCreated: _onMapWebViewCreated),
      tutorial: null,
      totalTravelTime: Duration(),
      nearbyPlacePopup: null,
      destinationName: "숭실대학교",
      routeGuidanceItems: [],
      onTimerClicked: () {},
      onBackButtonClicked: () {},
      onMenuButtonClicked: () {},
      onEmergencyButtonClicked: () {},
      onGoToCurrentLocationButtonClicked: () {},
    );
  }

  void _onMapWebViewCreated(InAppWebViewController controller) {
    controller.loadFile(
      assetFilePath: "packages/navigation/assets/htmls/map.html",
    );
    mapController = controller;
  }
}
