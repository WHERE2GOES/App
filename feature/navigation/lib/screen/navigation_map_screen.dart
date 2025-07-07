import 'dart:math';

import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navigation/model/nearby_place_popup_button_prop.dart';
import 'package:navigation/model/route_guidance_item_prop.dart';

class NavigationMapScreen extends StatefulWidget {
  const NavigationMapScreen({
    super.key,
    required this.mapWidget,
    required this.tutorialStep,
    required this.totalTravelTime,
    required this.nearbyPlacePopup,
    required this.destinationName,
    required this.routeGuidanceItems,
    required this.onTimerClicked,
    required this.onBackButtonClicked,
    required this.onMenuButtonClicked,
    required this.onEmergencyButtonClicked,
    required this.onGoToCurrentLocationButtonClicked,
  });

  final Widget mapWidget;
  final int? tutorialStep;
  final Duration totalTravelTime;
  final ({List<NearbyPlacePopupButtonProp> buttons})? nearbyPlacePopup;
  final String destinationName;
  final List<RouteGuidanceItemProp> routeGuidanceItems;
  final VoidCallback onTimerClicked;
  final VoidCallback onBackButtonClicked;
  final VoidCallback onMenuButtonClicked;
  final VoidCallback onEmergencyButtonClicked;
  final VoidCallback onGoToCurrentLocationButtonClicked;

  @override
  State<StatefulWidget> createState() => _NavigationMapScreenState();
}

class _NavigationMapScreenState extends State<NavigationMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(
                    iconAsset: "assets/images/ic_warning.png",
                    backgroundColor: ThemeColors.grey800,
                    onClicked: widget.onEmergencyButtonClicked,
                  ),
                  _buildIconButton(
                    iconAsset: "assets/images/ic_location.png",
                    backgroundColor: Colors.white,
                    onClicked: widget.onGoToCurrentLocationButtonClicked,
                  ),
                ],
              ),
            ),
            _buildNavigatingBottomSheetContent(),
          ],
        ),
        SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                left: 24,
                child: _buildIconButton(
                  iconAsset: "assets/images/ic_left_triangle_arrow.png",
                  backgroundColor: Colors.white,
                  onClicked: widget.onBackButtonClicked,
                ),
              ),
              GestureDetector(
                onTap: widget.onTimerClicked,
                child: Container(
                  width: 97.36,
                  height: 37.24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeColors.pastelYellow,
                    border: Border.all(color: ThemeColors.grey800, width: 0.6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "${widget.totalTravelTime.inHours.toString().padLeft(2, "0")}:${widget.totalTravelTime.inMinutes.remainder(60).toString().padLeft(2, "0")}",
                    style: const TextStyle(
                      fontSize: 20.73,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.grey800,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 24,
                child: _buildIconButton(
                  iconAsset: "assets/images/ic_hamburger.png",
                  backgroundColor: ThemeColors.pastelYellow,
                  onClicked: widget.onMenuButtonClicked,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String iconAsset,
    required Color backgroundColor,
    required VoidCallback onClicked,
  }) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        width: 40.33,
        height: 37.24,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: ThemeColors.grey800, width: 0.6),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.asset(
          iconAsset,
          package: "navigation",
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildNavigatingBottomSheetContent() {
    return CustomBottomSheet(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(13),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SvgPicture.asset(
                          "assets/images/ic_twinkle.svg",
                          package: "design",
                          width: 6.45,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: widget.destinationName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.pastelYellow,
                      ),
                    ),
                    TextSpan(
                      text: " 까지 경로를 안내해 드릴게요!",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 11.77),
                itemBuilder: (context, index) {
                  final item = widget.routeGuidanceItems[index];

                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6.22),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF61615C),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: ThemeColors.pastelGreen.withValues(
                                alpha: 0.4,
                              ),
                              width: 0.6,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 21,
                                    vertical: 6,
                                  ),
                                  child: Row(
                                    spacing: 6,
                                    children: [
                                      Transform.rotate(
                                        angle: switch (item.routeGuidanceType) {
                                          RouteGuidanceType.turnLeft => pi / 2,
                                          RouteGuidanceType.turnRight =>
                                            -pi / 2,
                                          _ => 0,
                                        },
                                        child: Image.asset(
                                          switch (item.routeGuidanceType) {
                                            RouteGuidanceType.straight =>
                                              "assets/images/ic_arrow_up.png",
                                            RouteGuidanceType.turnLeft =>
                                              "assets/images/ic_arrow_up.png",
                                            RouteGuidanceType.turnRight =>
                                              "assets/images/ic_arrow_up.png",
                                            RouteGuidanceType.crosswalk =>
                                              "assets/images/ic_crosswalk.png",
                                          },
                                          package: "navigation",
                                          width: 28,
                                        ),
                                      ),
                                      Text(
                                        item.description,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10.11,
                                  bottom: 3.62,
                                ),
                                child: Text(
                                  "${item.distance}m",
                                  style: const TextStyle(
                                    color: ThemeColors.pastelYellow,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 3.7,
                        child: Container(
                          width: 12.44,
                          height: 12.44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeColors.pastelGreen,
                          ),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                              color: ThemeColors.grey800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 6.46);
                },
                itemCount: widget.routeGuidanceItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
