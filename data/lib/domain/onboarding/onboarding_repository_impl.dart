import 'dart:typed_data';

import 'package:core/common/result.dart';
import 'package:core/domain/onboarding/onboarding_repository.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:data/utils/get_future_from_image_url.dart';
import 'package:injectable/injectable.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:openapi/openapi.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  final Openapi openapi;
  final AuthPreference authPreference;

  const OnboardingRepositoryImpl({
    required this.openapi,
    required this.authPreference,
  });

  @override
  Future<Result<Uint8List>> getBannerImage() async {
    try {
      final url = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getBannerControllerApi();
          final response = await api.getBanner(
            headers: {"Authorization": "Bearer $accessToken"},
          );
          return response.data!.data!.first;
        },
      );

      final image = await getFutureFromImageUrl(url);
      if (image == null) throw Exception("배너 이미지를 받아올 수 없습니다.");

      return Success(data: image);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }
}
