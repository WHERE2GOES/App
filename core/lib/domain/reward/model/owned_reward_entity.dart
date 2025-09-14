import 'package:freezed_annotation/freezed_annotation.dart';

part 'owned_reward_entity.freezed.dart';

@freezed
abstract class OwnedRewardEntity with _$OwnedRewardEntity {
  const factory OwnedRewardEntity({
    required int courseId,
    required String downloadLink,
  }) = _OwnedRewardEntity;
}
