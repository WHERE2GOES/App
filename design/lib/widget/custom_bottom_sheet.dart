import 'dart:math';

import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    required this.child,
    this.maxHeight,
    this.minHeight,
    this.initialHeight,
    this.showDragHandle = true,
    this.onHeightChanged,
  });

  final Widget child;
  final double? maxHeight;
  final double? minHeight;
  final double? initialHeight;
  final bool showDragHandle;
  final void Function(double height)? onHeightChanged;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  double _height = 0;
  double _heightAtDragStarted = 0;
  Offset _startPosition = Offset.zero;
  Offset _displacement = Offset.zero;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_height == 0) {
        final initialHeight =
            widget.initialHeight ?? MediaQuery.of(context).size.height * 0.3;
        setState(() => _height = initialHeight);
        widget.onHeightChanged?.call(initialHeight);
      }
    });

    return Container(
      width: double.infinity,
      height: _height,
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
          if (widget.showDragHandle)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _onDragStarted,
              onScaleUpdate: _onDragUpdated,
              onScaleEnd: _onDragEnded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              ),
            ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  void _onDragStarted(ScaleStartDetails details) {
    setState(() {
      _startPosition = details.focalPoint;
      _heightAtDragStarted = _height;
    });
  }

  void _onDragUpdated(ScaleUpdateDetails details) {
    final newHeight = max(
      widget.minHeight ?? 0,
      min(
        widget.maxHeight ?? double.infinity,
        _heightAtDragStarted - _displacement.dy,
      ),
    );

    setState(() {
      _displacement = details.focalPoint - _startPosition;
      _height = newHeight;
    });

    widget.onHeightChanged?.call(_height);
  }

  void _onDragEnded(ScaleEndDetails details) {
    setState(() {
      _displacement = Offset.zero;
      _heightAtDragStarted = 0;
    });
  }
}
