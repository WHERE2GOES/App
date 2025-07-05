import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_update_request.freezed.dart';

@freezed
abstract class ProfileUpdateRequest with _$ProfileUpdateRequest {
  const factory ProfileUpdateRequest({
    required String nickname,
    required Uint8List? profileImage,
  }) = _ProfileUpdateRequest;
}
