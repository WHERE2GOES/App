import 'dart:typed_data';

import 'package:core/common/result.dart';
import 'package:core/domain/onboarding/onboarding_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<Result<Uint8List>> getBannerImage() {
    // TODO: implement getBannerImage
    throw UnimplementedError();
  }
}