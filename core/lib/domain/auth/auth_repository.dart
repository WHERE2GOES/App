import 'package:core/common/result.dart';
import 'package:core/domain/auth/model/login_request.dart';

abstract interface class AuthRepository {
  /// 로그인 여부
  Future<Result<bool>> get isLoggedIn;

  /// 회원가입이 완료되지 않은 상태인지에 대한 여부
  Future<Result<bool>> get isSignUpPending;

  /// 로그인
  /// 
  /// 성공 여부를 반환한다.
  Future<Result<bool>> login({required LoginRequest request});

  /// 로그아웃
  /// 
  /// 성공 여부를 반환한다.
  Future<Result<bool>> logout();
}
