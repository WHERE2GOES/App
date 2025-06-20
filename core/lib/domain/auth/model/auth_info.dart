import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_info.freezed.dart';

@freezed
abstract class AuthInfo with _$AuthInfo {
  const factory AuthInfo({
    required AuthProvider authProvider,
    required AuthTokenType authTokenType,
    required String accessToken,
    required String? idToken,
  }) = _AuthInfo;
}

enum AuthTokenType { bearer }
enum AuthProvider { google, apple, kakao, naver }
