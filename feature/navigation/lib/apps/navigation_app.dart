import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:navigation/models/place_prop.dart';
import 'package:navigation/models/place_type.dart';
import 'package:navigation/screens/navigation_map_screen.dart';
import 'package:navigation/screens/navigation_nearby_place_screen.dart';
import 'package:navigation/utils/determine_position.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

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
      onBackButtonClicked: () {},
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
      SystemNavigator.pop();
    }
  }

  void _onMapWebViewCreated(InAppWebViewController controller) {
    controller.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          "https://where-to-goes-navigation.netlify.app/?latlngs=37.55737548,126.603468n37.55563357,126.6057874n37.55452492,126.6073606n37.55490635,126.6075829n37.55520119,126.6078804n37.55535694,126.6083086n37.5553483,126.6088131n37.55525338,126.6093161n37.55502871,126.6100098n37.55529303,126.6120167n37.55582862,126.6169696n37.55673135,126.6219347n37.56003322,126.6205404n37.56046596,126.6221566n37.56064324,126.6224731n37.5608358,126.6224928n37.56358812,126.6213212n37.56443593,126.6208207n37.56502182,126.6203118n37.56526792,126.6213076n37.56713167,126.6280156n37.56731616,126.6290147n37.56862093,126.6340634n37.56893806,126.6351448n37.56900507,126.6352249n37.56918001,126.6353063n37.56920971,126.635355n37.56983101,126.6375217n37.57016365,126.6393785n37.57025916,126.6403801n37.57039695,126.6429887n37.57061191,126.6484948n37.57150633,126.6602689n37.57156009,126.6613775n37.5715223,126.6614464n37.57152019,126.6615403n37.57158268,126.6626426n37.57165282,126.6628205n37.5717181,126.6632192n37.57177661,126.6638276n37.57175494,126.6656034n37.57169328,126.6666681n37.57138091,126.6702527n37.57121058,126.6708248n37.57113888,126.672023n37.57116348,126.6726607n37.57103047,126.6741191n37.57102366,126.6746399n37.57083176,126.674999n37.57065666,126.676551n37.57044278,126.680092n37.57069693,126.6805574n37.57070892,126.6833527n37.57082961,126.6858686n37.57087943,126.6861369n37.57090029,126.6886307n37.57100763,126.6924011n37.57234836,126.721549n37.57232642,126.7226989n37.57274063,126.7324703n37.5730362,126.7367977n37.57298386,126.7372642n37.57304635,126.7400868n37.573123,126.7416785n37.57313977,126.7438619n37.57324758,126.7460061n37.57328515,126.746256n37.57328948,126.746934n37.57340028,126.749558n37.57349352,126.7511669n37.5735676,126.751938n37.57380152,126.7534795n37.57368606,126.7540404n37.57369799,126.7541759n37.57385282,126.7545916n37.57384197,126.7555027n37.57381306,126.7557464n37.57378058,126.7558614n37.57347407,126.7564069n37.57345004,126.7565462n37.57351358,126.7574079n37.57369392,126.7585258n37.57412188,126.7599678n37.57434778,126.7604663n37.57499101,126.76143n37.5751182,126.7615227n37.57545326,126.7616654n37.5755429,126.7617271n37.57561828,126.7618333n37.57628794,126.7630419n37.57743962,126.7648873n37.57864488,126.7664518n37.58005394,126.7681581n37.58189658,126.7706004n37.58221519,126.7711086n37.58288161,126.7718667n37.58414188,126.7734595n37.58749758,126.7779277n37.59107988,126.7826219n37.59242987,126.7843215n37.59245148,126.7846899n37.59293791,126.7857268n37.59164853,126.7878277n37.59082411,126.7892498n37.59065656,126.7896131n37.59059665,126.790082n37.59062407,126.7903461n37.59082724,126.790998n37.59291663,126.7960821n37.59358329,126.7979431n37.59368286,126.79814n37.59473345,126.7974851n37.5968703,126.7965443n37.59703254,126.7965243n37.59723949,126.796578n37.59763798,126.7969761n37.59876086,126.8000577n37.59867711,126.8001093",
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
