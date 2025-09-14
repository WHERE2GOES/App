import 'package:core/common/result.dart';
import 'package:core/domain/reward/model/certificate_entity.dart';
import 'package:core/domain/reward/model/owned_reward_entity.dart';

abstract interface class RewardRepository {
  /// 소유한 보상 목록
  Future<Result<List<OwnedRewardEntity>>> getOwnedRewards();

  /// 현재 진행중인 코스의 인증소 목록 조회
  Future<Result<List<CertificateEntity>>> getCertificates();

  /// 인증소의 QR 코드값으로 인증소 방문 인증
  Future<Result<void>> authenticateCertificate({
    required int certificateId,
    required String qrCode,
  });
}
