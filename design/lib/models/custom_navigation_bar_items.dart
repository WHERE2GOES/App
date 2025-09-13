enum CustomNavigationBarItems {
  home(iconAsset: "packages/design/assets/images/ic_home_circle.svg"),
  navigation(iconAsset: "packages/design/assets/images/ic_pin_circle.svg"),
  reward(iconAsset: "packages/design/assets/images/ic_star_circle.svg"),
  profile(iconAsset: "packages/design/assets/images/ic_profile_circle.svg");

  final String iconAsset;

  const CustomNavigationBarItems({required this.iconAsset});
}
