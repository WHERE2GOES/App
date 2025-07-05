import 'package:collection/collection.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navigation/model/place_category_button_prop.dart';
import 'package:navigation/model/place_prop.dart';

final _animationDuration = const Duration(milliseconds: 100);

class NavigationNearbyPlaceScreen extends StatefulWidget {
  const NavigationNearbyPlaceScreen({
    super.key,
    required this.placeCagetoryButtons,
    required this.selectedPlaceCategoryIndex,
    required this.places,
    required this.shouldShowLoadingIndicatorAtBottom,
    required this.onLastPlaceRendered,
  });

  final List<PlaceCategoryButtonProp> placeCagetoryButtons;
  final int selectedPlaceCategoryIndex;
  final List<PlaceProp> places;
  final bool shouldShowLoadingIndicatorAtBottom;
  final VoidCallback onLastPlaceRendered;

  @override
  State<NavigationNearbyPlaceScreen> createState() =>
      _NavigationNearbyPlaceScreenState();
}

class _NavigationNearbyPlaceScreenState
    extends State<NavigationNearbyPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.sparseYellow,
      padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.48),
            child: _buildPlaceCategoryButtons(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.48),
              child: _buildPlaces(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceCategoryButtons() {
    return Row(
      spacing: 9.77,
      children: widget.placeCagetoryButtons.mapIndexed((index, e) {
        final isSelected = index == widget.selectedPlaceCategoryIndex;

        return Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  AnimatedSize(
                    duration: _animationDuration,
                    child: SizedBox(height: isSelected ? 0 : 10.5),
                  ),
                  GestureDetector(
                    onTap: e.onClicked,
                    child: Container(
                      height: 37.24,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ThemeColors.pastelYellow
                            : ThemeColors.grey300,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: ThemeColors.grey800,
                          width: 0.6,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          e.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.grey800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.37),
                ],
              ),
              AnimatedOpacity(
                duration: _animationDuration,
                opacity: isSelected ? 1 : 0,
                child: Container(
                  width: 10.1,
                  height: 10.1,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ThemeColors.pastelYellow
                        : ThemeColors.grey300,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 0.6),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPlaces() {
    return ListView.separated(
      padding: EdgeInsets.only(
        top: 15,
        bottom: MediaQuery.viewPaddingOf(context).bottom,
      ),
      itemBuilder: (context, index) {
        if (index == widget.places.length) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (index == widget.places.length - 1) {
          widget.onLastPlaceRendered();
        }

        final place = widget.places[index];

        return Container(
          decoration: BoxDecoration(
            color: place.isHighligted ? Colors.white : Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ThemeColors.grey800, width: 0.6),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 9.25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.98),
                    child: Container(
                      width: 65.27,
                      height: 26.55,
                      decoration: BoxDecoration(
                        color: place.isHighligted
                            ? ThemeColors.highlightedRed
                            : ThemeColors.grey300,
                        borderRadius: BorderRadius.circular(3.56),
                        border: Border.all(
                          color: ThemeColors.grey800,
                          width: 0.6,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${place.distance}M",
                          style: TextStyle(
                            color: place.isHighligted
                                ? Colors.white
                                : ThemeColors.grey800,
                            fontSize: 12.83,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11.15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.86),
                    child: Text(
                      place.name,
                      style: const TextStyle(
                        color: ThemeColors.grey800,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 11.86),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.98),
                    child: Row(
                      spacing: 5.68,
                      children: [
                        Container(
                          width: 34.95,
                          height: 34.95,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: place.isHighligted
                                ? ThemeColors.pastelYellow
                                : ThemeColors.grey300,
                            border: Border.all(
                              color: ThemeColors.grey800,
                              width: 0.6,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              switch (place.placeDetailIcon) {
                                PlaceDetailIcon.human =>
                                  "assets/images/ic_human.svg",
                                PlaceDetailIcon.pin =>
                                  "assets/images/ic_pin.svg",
                              },
                              package: "navigation",
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Text(
                          switch (place.placeClickingBahaviorText) {
                            PlaceClickingBahaviorText.viewLocation =>
                              "위치보기",
                            PlaceClickingBahaviorText.findRoute => "길찾기",
                          },
                          style: TextStyle(
                            color: ThemeColors.grey800.withValues(alpha: 0.66),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9.45),
                ],
              ),
              Positioned(
                right: 10,
                bottom: 8.9,
                child: GestureDetector(
                  onTap: place.onLikeButtonClicked,
                  child: Row(
                    spacing: 2.44,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/ic_heart.png",
                        package: "navigation",
                        width: 19.03,
                        color: place.isLiked
                            ? ThemeColors.highlightedRed
                            : ThemeColors.grey800,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      Container(
                        constraints: const BoxConstraints(minWidth: 26),
                        child: Text(
                          place.likeCount.toString(),
                          style: TextStyle(
                            color: place.isLiked
                                ? ThemeColors.highlightedRed
                                : ThemeColors.grey800,
                            fontSize: 15.57,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 22.51);
      },
      itemCount:
          widget.places.length +
          (widget.shouldShowLoadingIndicatorAtBottom ? 1 : 0),
    );
  }
}
