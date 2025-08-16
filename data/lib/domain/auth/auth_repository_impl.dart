import 'package:core/common/result.dart';
import 'package:core/domain/auth/auth_repository.dart';
import 'package:core/domain/auth/model/auth_provider.dart';
import 'package:core/domain/auth/model/auth_token_type.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:data/sources/server/exceptions/user_register_pending_exception.dart';
import 'package:data/sources/server/services/server_api_service.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthPreference authPreference;
  final ServerApiService serverApiService;

  const AuthRepositoryImpl({
    @Named.from(AuthPreference) required this.authPreference,
    @Named.from(ServerApiService) required this.serverApiService,
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
      final response = switch (authProvider) {
        AuthProvider.kakao => await serverApiService.loginWithKakao(
          token: accessToken,
        ),

        AuthProvider.google => await serverApiService.loginWithGoogle(
          token: accessToken,
        ),

        _ => throw UnimplementedError("Unimplemented authorization provider."),
      };

      await authPreference.setAccessToken(response.accessToken);
      await authPreference.setRefreshToken(response.refreshToken);
      await authPreference.setPendingEmail(null);
      await authPreference.setPendingEmailDomain(null);

      return Success(data: true);
    } on Exception catch (e) {
      if (e is UserRegisterPendingException) {
        await authPreference.setPendingEmail(e.email);
        await authPreference.setPendingEmailDomain(e.domain);

        return Success(data: false);
      } else {
        return Failure(exception: e);
      }
    }
  }

  @override
  Future<Result<bool>> logout() async {
    try {
      await callWithAuth(
        authPreference: authPreference,
        serverApiService: serverApiService,
        action: (accessToken) async {
          await serverApiService.logout(accessToken: accessToken);
        },
      );

      await authPreference.clear();

      return Success(data: true);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }
}
