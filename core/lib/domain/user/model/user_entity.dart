import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String nickname,
    required String email,
    required Future<Uint8List>? profileImage,
  }) = _UserEntity;
}
