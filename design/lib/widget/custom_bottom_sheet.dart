import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: ThemeColors.grey800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: Container(
              color: ThemeColors.pastelYellow,
              height: 3.62,
              constraints: const BoxConstraints(maxWidth: 44.57),
              child: SizedBox.expand(),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}
