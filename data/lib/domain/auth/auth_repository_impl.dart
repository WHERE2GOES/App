import 'package:core/common/result.dart';
import 'package:core/domain/auth/auth_repository.dart';
import 'package:core/domain/auth/model/auth_provider.dart';
import 'package:core/domain/auth/model/auth_token_type.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final Openapi openapi;
  final AuthPreference authPreference;

  const AuthRepositoryImpl({
    required this.openapi,
    required this.authPreference,
  });

  @override
  Future<Result<bool>> get isLoggedIn async {
    try {
      final isLoggedIn = (await authPreference.refreshToken) != null;
      return Success(data: isLoggedIn);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<bool>> get isSignUpPending async {
    try {
      final email = await authPreference.pendingEmail;
      final domain = await authPreference.pendingEmailDomain;

      return Success(data: email != null || domain != null);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<bool>> login({
    required AuthProvider authProvider,
    required AuthTokenType authTokenType,
    required String accessToken,
    required String? idToken,
  }) async {
    try {
      final request = LoginRequest((b) => b..accessToken = accessToken);
      final api = openapi.getLoginAPIApi();

      final response = switch (authProvider) {
        AuthProvider.kakao => await api.loginKakao(loginRequest: request),
        AuthProvider.google => await api.loginGoogle(loginRequest: request),
        _ => throw UnimplementedError(),
      };

      final at = response.data?.data?.accessToken;
      final rt = response.data?.data?.refreshToken;

      if (at == null || rt == null) throw Exception("Login failed.");

      await authPreference.setAccessToken(at);
      await authPreference.setRefreshToken(rt);
      await authPreference.setPendingEmail(null);
      await authPreference.setPendingEmailDomain(null);

      return Success(data: true);
    } on DioException catch (e) {
      // 사용자가 가입 절차를 완료하지 않음
      if (e.response?.statusCode == 404) {
        final email = e.response?.data?["data"]?["email"];
        final domain = e.response?.data?["data"]?["domain"];

        if (email is String && domain is String) {
          await authPreference.setPendingEmail(email);
          await authPreference.setPendingEmailDomain(domain);

          return Success(data: false);
        } else {
          throw Exception("Login failed. No email returned");
        }
      }

      rethrow;
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      final isSucceed = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getLoginAPIApi();
          final response = await api.logout(
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.statusCode == 200;
        },
      );

      if (!isSucceed) throw Exception("Logout failed.");

      return Success(data: null);
    } on Exception catch (e) {
      return Failure(exception: e);
    } finally {
      await authPreference.clear();
    }
  }
}
