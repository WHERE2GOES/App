enum PlaceType {
  restroom(
    label: '화장실',
    imageAsset: 'assets/images/img_place_restroom.svg',
  ),
  accommodation(
    label: '숙소',
    imageAsset: 'assets/images/img_place_accommodation.svg',
  ),
  restaurant(
    label: '식당',
    imageAsset: 'assets/images/img_place_restaurant.svg',
  );

  const PlaceType({required this.label, required this.imageAsset});

  final String label;
  final String imageAsset;
}
