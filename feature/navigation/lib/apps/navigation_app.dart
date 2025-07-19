import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:navigation/models/place_prop.dart';
import 'package:navigation/models/place_type.dart';
import 'package:navigation/screens/navigation_map_screen.dart';
import 'package:navigation/screens/navigation_nearby_place_screen.dart';
import 'package:navigation/utils/determine_position.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key, this.initialCoursePositionString});

  final String? initialCoursePositionString;

  @override
  State<StatefulWidget> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  InAppWebViewController? mapController;

  bool _shouldShowNearbyPlacePopup = false;
  PlaceType? _selectedPlaceType;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return BackButtonListener(
              onBackButtonPressed: () async {
                _back();
                return true;
              },
              child: switch (settings.name) {
                '/' => _buildNavigationMapScreen(),
                '/nearby-place' => _buildNavigationNearbyPlaceScreen(),
                _ => throw Exception("Invalid route"),
              },
            );
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
      nearbyPlacePopup: _shouldShowNearbyPlacePopup
          ? (
              buttons: PlaceType.values
                  .map(
                    (placeType) => (
                      imageAsset: placeType.imageAsset,
                      onClicked: () {
                        setState(() {
                          _shouldShowNearbyPlacePopup = false;
                          _selectedPlaceType = placeType;
                        });
                        _navigatorKey.currentState?.pushNamed("/nearby-place");
                      },
                    ),
                  )
                  .toList(),
              onDismissed: () =>
                  setState(() => _shouldShowNearbyPlacePopup = false),
            )
          : null,
      destinationName: "숭실대학교",
      routeGuidanceItems: [],
      onTimerClicked: () {},
      onBackButtonClicked: _back,
      onMenuButtonClicked: () => setState(
        () => _shouldShowNearbyPlacePopup = !_shouldShowNearbyPlacePopup,
      ),
      onEmergencyButtonClicked: () {},
      onGoToCurrentLocationButtonClicked: _moveMapToCurrentPosition,
    );
  }

  Widget _buildNavigationNearbyPlaceScreen() {
    return NavigationNearbyPlaceScreen(
      placeCagetoryButtons: PlaceType.values
          .map(
            (placeType) => (
              name: placeType.label,
              onClicked: () => setState(() => _selectedPlaceType = placeType),
            ),
          )
          .toList(),
      selectedPlaceCategoryIndex: _selectedPlaceType?.index ?? 0,
      places: [
        (
          distance: 75,
          name: "올리브영 옆 화장실",
          isHighligted: true,
          placeDetailIcon: PlaceDetailIcon.human,
          placeClickingBahaviorText: PlaceClickingBahaviorText.viewLocation,
          likeCount: 200,
          isLiked: true,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 120,
          name: "스타벅스 안 상가 화장실",
          isHighligted: true,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 125,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 235,
          name: "공용 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 45,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 325,
          name: "메가커피 안 상가 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 20,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 400,
          name: "올리브영 옆 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 14,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 75,
          name: "올리브영 옆 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.human,
          placeClickingBahaviorText: PlaceClickingBahaviorText.viewLocation,
          likeCount: 200,
          isLiked: true,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 120,
          name: "스타벅스 안 상가 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 125,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 235,
          name: "공용 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 45,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 325,
          name: "메가커피 안 상가 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 20,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
        (
          distance: 400,
          name: "올리브영 옆 화장실",
          isHighligted: false,
          placeDetailIcon: PlaceDetailIcon.pin,
          placeClickingBahaviorText: PlaceClickingBahaviorText.findRoute,
          likeCount: 14,
          isLiked: false,
          onClicked: () {},
          onLikeButtonClicked: () {},
        ),
      ],
      shouldShowLoadingIndicatorAtBottom: false,
      onLastPlaceRendered: () {},
    );
  }

  void _back() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _onMapWebViewCreated(InAppWebViewController controller) {
    final positions = widget.initialCoursePositionString;

    controller.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          [
            "https://where-to-goes-navigation.netlify.app",
            if (positions != null) "/?latlngs=$positions",
          ].join(''),
        ),
      ),
    );
    mapController = controller;
  }

  void _moveMapToCurrentPosition() async {
    final currentLocation = await determinePosition();
    print(currentLocation.latitude);
    print(currentLocation.longitude);

    mapController?.evaluateJavascript(
      source: [
        "window.panMapTo(",
        currentLocation.latitude.toString(),
        ",",
        currentLocation.longitude.toString(),
        ");",
      ].join(),
    );
  }
}
