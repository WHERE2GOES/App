import 'package:core/domain/auth/model/auth_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';

@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required AuthInfo authInfo,
  }) = _LoginRequest;
}
