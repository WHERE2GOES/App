import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_response.freezed.dart';

@freezed
abstract class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required String accessToken,
    required String refreshToken,
  }) = _TokenResponse;
}
