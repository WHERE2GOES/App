import 'package:core/common/result.dart';
import 'package:core/domain/auth/model/login_request.dart';

abstract interface class AuthRepository {
  /// 로그인 여부
  Future<bool> get isLoggedIn;

  /// 로그인
  Future<Result<bool>> login({required LoginRequest request});

  /// 로그아웃
  Future<Result<bool>> logout();
}
