import 'dart:ui';

typedef PlaceProp = ({
  int distance,
  String name,
  bool isHighligted,
  PlaceDetailIcon placeDetailIcon,
  PlaceClickingBahaviorText placeClickingBahaviorText,
  int likeCount,
  bool isLiked,
  VoidCallback onClicked,
  VoidCallback onLikeButtonClicked,
});

enum PlaceDetailIcon {
  human,
  pin,
}

enum PlaceClickingBahaviorText {
  viewLocation,
  findRoute,
}
