import 'dart:ui';

enum CoursePreferenceBackgroundType {
  a(
    background: Color(0xFFF78787),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background8.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco8.svg",
    decorationOffset: Offset(-36.4, -108.68),
    decorationSize: Size(547.85, 1182.54),
  ),
  b(
    background: Color(0xFF87E4F7),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background4.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco4.svg",
    decorationOffset: Offset(-175.4, -15.66),
    decorationSize: Size(663.36, 1223.77),
  ),
  c(
    background: Color(0xFFFF8761),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background2.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco2.svg",
    decorationOffset: Offset(-153.28, -392.71),
    decorationSize: Size(710.57, 1535.78),
  ),
  d(
    background: Color(0xFFED61FF),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background1.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco1.svg",
    decorationOffset: Offset(12.09, -208.94),
    decorationSize: Size(518.81, 1203.43),
  ),
  e(
    background: Color(0xFF90F787),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background3.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco3.svg",
    decorationOffset: Offset(-41.31, -321.97),
    decorationSize: Size(544.76, 1332.64),
  ),
  f(
    background: Color(0xFF879FF7),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background7.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco7.svg",
    decorationOffset: Offset(-218.75, -385.65),
    decorationSize: Size(716.18, 1297.97),
  ),
  g(
    background: Color(0xFFF7BB87),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background6.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco6.svg",
    decorationOffset: Offset(-160.01, -210.24),
    decorationSize: Size(782.24, 1345.55),
  ),
  h(
    background: Color(0xFFF7E887),
    backgroundAsset: "packages/design/assets/images/img_course_preference_background5.png",
    backgroundOffset: Offset(-349.955, -389.54),
    backgroundSize: Size(1129, 1545),
    decorationAsset: "packages/design/assets/images/img_course_preference_deco5.svg",
    decorationOffset: Offset(-123.01, -119.01),
    decorationSize: Size(821.28, 851.72),
  );

  final Color background;
  final String backgroundAsset;
  final Offset backgroundOffset;
  final Size backgroundSize;
  final String decorationAsset;
  final Offset decorationOffset;
  final Size decorationSize;

  const CoursePreferenceBackgroundType({
    required this.background,
    required this.backgroundAsset,
    required this.backgroundOffset,
    required this.backgroundSize,
    required this.decorationAsset,
    required this.decorationOffset,
    required this.decorationSize,
  });
}