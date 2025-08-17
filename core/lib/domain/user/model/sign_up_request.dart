import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';

@freezed
abstract class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    required String nickname,
    required Iterable<({int questionId, int selectedOptionIndex})> preferences,
  }) = _SignUpRequest;
}
