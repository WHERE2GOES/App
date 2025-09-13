import 'package:design/models/custom_navigation_bar_items.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentItem,
    required this.onItemTapped,
  });

  final CustomNavigationBarItems currentItem;
  final void Function(CustomNavigationBarItems) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: ThemeColors.grey800,
      child: Row(
        children: CustomNavigationBarItems.values.map((e) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onItemTapped(e),
              child: Center(child: SvgPicture.asset(e.iconAsset, width: 42.17)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
