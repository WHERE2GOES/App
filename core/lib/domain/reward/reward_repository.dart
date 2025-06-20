import 'package:core/common/result.dart';
import 'package:core/domain/reward/model/owned_reward_entity.dart';

abstract interface class RewardRepository {
  /// 소유한 보상 목록
  Future<Result<List<OwnedRewardEntity>>> get ownedRewards;
}