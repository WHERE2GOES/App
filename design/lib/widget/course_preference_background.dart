import 'dart:math';

import 'package:design/models/course_preference_background_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoursePreferenceBackground extends StatelessWidget {
  const CoursePreferenceBackground({super.key, required this.type});

  final CoursePreferenceBackgroundType type;
  final Size originalSize = const Size(360, 800);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final widthRatio = size.width / originalSize.width;
    final heightRatio = size.height / originalSize.height;
    final ratio = min(widthRatio, heightRatio);

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: type.background,
      child: SizedBox(
        width: originalSize.width * ratio,
        height: originalSize.height * ratio,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: type.backgroundOffset.dx * ratio,
              top: type.backgroundOffset.dy * ratio,
              child: Image.asset(
                type.backgroundAsset,
                width: type.backgroundSize.width * ratio,
                height: type.backgroundSize.height * ratio,
              ),
            ),
            Positioned(
              left: type.decorationOffset.dx * ratio,
              top: type.decorationOffset.dy * ratio,
              child: SvgPicture.asset(
                type.decorationAsset,
                width: type.decorationSize.width * ratio,
                height: type.decorationSize.height * ratio,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
