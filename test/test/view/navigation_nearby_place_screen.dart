import 'package:flutter/material.dart';
import 'package:navigation/model/place_prop.dart';
import 'package:navigation/screen/navigation_nearby_place_screen.dart';

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
  int _selectedPlaceCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationNearbyPlaceScreen(
        placeCagetoryButtons: [
          (
            name: "화장실",
            onClicked: () {
              setState(() {
                _selectedPlaceCategoryIndex = 0;
              });
            },
          ),
          (
            name: "숙박업소",
            onClicked: () {
              setState(() {
                _selectedPlaceCategoryIndex = 1;
              });
            },
          ),
          (
            name: "음식점",
            onClicked: () {
              setState(() {
                _selectedPlaceCategoryIndex = 2;
              });
            },
          ),
        ],
        selectedPlaceCategoryIndex: _selectedPlaceCategoryIndex,
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
        shouldShowLoadingIndicatorAtBottom: true,
        onLastPlaceRendered: () {},
      ),
    );
  }
}
