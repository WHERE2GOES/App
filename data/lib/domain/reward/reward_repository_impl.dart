import 'package:core/domain/reward/model/owned_reward_entity.dart';
import 'package:core/domain/reward/model/certificate_entity.dart';
import 'package:core/common/result.dart';
import 'package:core/domain/reward/reward_repository.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart';

@LazySingleton(as: RewardRepository)
class RewardRepositoryImpl implements RewardRepository {
  final AuthPreference authPreference;
  final Openapi openapi;

  RewardRepositoryImpl(this.authPreference, this.openapi);

  @override
  Future<Result<List<OwnedRewardEntity>>> getOwnedRewards() {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<CertificateEntity>>> getCertificates() async {
    try {
      final currentCourse = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getCourseControllerApi();
          final response = await api.getCurrentCourse(
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.data?.data;
        },
      );

      final response = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getCertificationControllerApi();
          final response = await api.getCertificationsByCourse(
            courseId: currentCourse!.courseId!,
            headers: {"Authorization": "Bearer $accessToken"},
          );
          return response.data?.data;
        },
      );

      return Success(
        data: response!.certifications!
            .map(
              (e) => CertificateEntity(
                id: e.placeId!,
                name: e.placeName!,
                isCompleted: false, // TODO: 백엔드 지원 시 연결
              ),
            )
            .toList(),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<void>> authenticateCertificate({
    required int certificateId,
    required String qrCode,
  }) async {
    try {
      final isSucceed = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getCertificationControllerApi();
          final response = await api.certify(
            certificationRequest: CertificationRequest(
              (b) => b
                ..placeId = certificateId
                ..hash = qrCode,
            ),
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.statusCode == 200;
        },
      );

      if (!isSucceed) throw Exception("Authentication failed.");
      return Success(data: null);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }
}
