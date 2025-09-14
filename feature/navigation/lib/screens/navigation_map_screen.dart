import 'dart:math';

import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navigation/models/nearby_place_popup_button_prop.dart';
import 'package:navigation/models/route_guidance_item_prop.dart';

final _overlapBetweenMapAndBottomSheet = 16.0;

class NavigationMapScreen extends StatefulWidget {
  const NavigationMapScreen({
    super.key,
    required this.mapWidget,
    required this.tutorial,
    required this.totalTravelTime,
    required this.nearbyPlacePopup,
    required this.destinationName,
    required this.routeGuidanceItems,
    required this.onTimerClicked,
    required this.onMenuButtonClicked,
    required this.onEmergencyButtonClicked,
    required this.onGoToCurrentLocationButtonClicked,
  });

  final Widget mapWidget;
  final ({int step, VoidCallback onDismissed})? tutorial;
  final Duration totalTravelTime;
  final ({List<NearbyPlacePopupButtonProp> buttons, VoidCallback onDismissed})?
  nearbyPlacePopup;
  final String destinationName;
  final List<RouteGuidanceItemProp>? routeGuidanceItems;
  final VoidCallback onTimerClicked;
  final VoidCallback onMenuButtonClicked;
  final VoidCallback onEmergencyButtonClicked;
  final VoidCallback onGoToCurrentLocationButtonClicked;

  @override
  State<StatefulWidget> createState() => _NavigationMapScreenState();
}

class _NavigationMapScreenState extends State<NavigationMapScreen> {
  final _timerKey = GlobalKey();
  final _menuKey = GlobalKey();

  OverlayEntry? _tutorialOverlayEntry;
  OverlayEntry? _nearbyPlacePopupOverlayEntry;
  double? _bottomSheetHeight;

  @override
  void dispose() {
    _hideTutorial();
    _hideNearbyPlacePopup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
      _checkAndShowNearbyPlacePopup();
    });

    final tutorial = widget.tutorial;
    final nearbyPlacePopup = widget.nearbyPlacePopup;

    return Stack(
      fit: StackFit.expand,
      children: [
        Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox.expand(child: widget.mapWidget),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // _buildIconButton(
                                //   iconAsset: "assets/images/ic_warning.png",
                                //   backgroundColor: ThemeColors.grey800,
                                //   onClicked: widget.onEmergencyButtonClicked,
                                // ),
                                _buildIconButton(
                                  iconAsset: "assets/images/ic_location.png",
                                  backgroundColor: Colors.white,
                                  onClicked:
                                      widget.onGoToCurrentLocationButtonClicked,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: _overlapBetweenMapAndBottomSheet),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height:
                      (_bottomSheetHeight ?? _overlapBetweenMapAndBottomSheet) -
                      _overlapBetweenMapAndBottomSheet,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildNavigatingBottomSheetContent(),
            ),
          ],
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // GestureDetector(
                //   key: _timerKey,
                //   onTap: widget.onTimerClicked,
                //   child: Container(
                //     width: 97.36,
                //     height: 37.24,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //       color: ThemeColors.pastelYellow,
                //       border: Border.all(
                //         color: ThemeColors.grey800,
                //         width: 0.6,
                //       ),
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     child: Text(
                //       "${widget.totalTravelTime.inHours.toString().padLeft(2, "0")}:${widget.totalTravelTime.inMinutes.remainder(60).toString().padLeft(2, "0")}",
                //       style: const TextStyle(
                //         fontSize: 20.73,
                //         fontWeight: FontWeight.w600,
                //         color: ThemeColors.grey800,
                //       ),
                //     ),
                //   ),
                // ),
                Positioned(
                  right: 0,
                  child: _buildIconButton(
                    key: _menuKey,
                    iconAsset: "assets/images/ic_hamburger.png",
                    backgroundColor: ThemeColors.pastelYellow,
                    onClicked: widget.onMenuButtonClicked,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (tutorial != null)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: tutorial.onDismissed,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: ThemeColors.grey800.withValues(alpha: 0.7),
            ),
          ),
        if (nearbyPlacePopup != null)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: nearbyPlacePopup.onDismissed,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: ThemeColors.grey800.withValues(alpha: 0.7),
            ),
          ),
      ],
    );
  }

  Widget _buildIconButton({
    Key? key,
    required String iconAsset,
    required Color backgroundColor,
    required VoidCallback onClicked,
  }) {
    return GestureDetector(
      key: key,
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
    final routeGuidanceItems = widget.routeGuidanceItems;
    if (routeGuidanceItems == null) return const SizedBox.shrink();

    return CustomBottomSheet(
      maxHeight: MediaQuery.of(context).size.height * 0.75,
      minHeight: MediaQuery.of(context).size.height * 0.25,
      onHeightChanged: (height) => setState(() => _bottomSheetHeight = height),
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
                final item = routeGuidanceItems[index];

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
                                        RouteGuidanceType.turnRight => -pi / 2,
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
                                    Expanded(
                                      child: Text(
                                        item.description,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
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
              itemCount: routeGuidanceItems.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyPlacePopup() {
    final nearbyPlacePopup = widget.nearbyPlacePopup;
    if (nearbyPlacePopup == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.65, vertical: 15.08),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ThemeColors.grey800, width: 0.6),
      ),
      child: Column(
        spacing: 15,
        mainAxisSize: MainAxisSize.min,
        children: nearbyPlacePopup.buttons
            .map(
              (button) => GestureDetector(
                onTap: button.onClicked,
                child: SvgPicture.asset(
                  button.imageAsset,
                  package: "navigation",
                  width: 166.37,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _checkAndShowTutorial() {
    final tutorial = widget.tutorial;
    final tutorialOverlayEntry = _tutorialOverlayEntry;
    if (tutorialOverlayEntry != null && tutorial == null) _hideTutorial();
    if (tutorialOverlayEntry != null || tutorial == null) return;

    final renderBox = switch (tutorial.step) {
      0 => _timerKey.currentContext?.findRenderObject(),
      1 => _menuKey.currentContext?.findRenderObject(),
      _ => throw Exception("Invalid tutorial step"),
    };
    if (renderBox is! RenderBox) return;

    final anchor = renderBox.localToGlobal(Offset.zero);
    final start = switch (tutorial.step) {
      0 => anchor - Offset(31.83, 0),
      1 => anchor - Offset(267.98, 15.04),
      _ => throw Exception("Invalid tutorial step"),
    };

    final newTutorialOverlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: start.dy,
          left: start.dx,
          child: SvgPicture.asset(
            switch (tutorial.step) {
              0 => "assets/images/img_tutorial_timer.svg",
              1 => "assets/images/img_tutorial_menu.svg",
              _ => throw Exception("Invalid tutorial step"),
            },
            package: "navigation",
            width: switch (tutorial.step) {
              0 => 245.11,
              1 => 308.31,
              _ => throw Exception("Invalid tutorial step"),
            },
          ),
        );
      },
    );

    Overlay.of(context).insert(newTutorialOverlayEntry);
    _tutorialOverlayEntry = newTutorialOverlayEntry;
  }

  void _hideTutorial() {
    _tutorialOverlayEntry?.remove();
    _tutorialOverlayEntry = null;
  }

  void _checkAndShowNearbyPlacePopup() {
    final nearbyPlacePopup = widget.nearbyPlacePopup;
    if (nearbyPlacePopup == null) {
      _hideNearbyPlacePopup();
      return;
    }

    final renderBox = _menuKey.currentContext?.findRenderObject();
    if (renderBox is! RenderBox) return;

    final anchor = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final newOverlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: anchor.dy + size.height + 13,
          right: 24,
          child: _buildNearbyPlacePopup(),
        );
      },
    );

    Overlay.of(context).insert(newOverlayEntry);
    _nearbyPlacePopupOverlayEntry = newOverlayEntry;
  }

  void _hideNearbyPlacePopup() {
    _nearbyPlacePopupOverlayEntry?.remove();
    _nearbyPlacePopupOverlayEntry = null;
  }
}
