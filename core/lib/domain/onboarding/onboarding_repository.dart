import 'dart:typed_data';

import 'package:core/common/result.dart';

abstract interface class OnboardingRepository {
  /// 온보딩 배너 이미지
  Future<Result<Uint8List>> getBannerImage();
}