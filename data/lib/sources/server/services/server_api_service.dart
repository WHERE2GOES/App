import 'package:data/sources/server/exceptions/user_register_pending_exception.dart';
import 'package:data/sources/server/objects/token_response.dart' as s;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:openapi/openapi.dart';

@lazySingleton
class ServerApiService {
  final Openapi openapi;

  const ServerApiService({@Named.from(Openapi) required this.openapi});

  Future<s.TokenResponse> loginWithKakao({required String token}) async {
    try {
      final request = LoginRequest((b) => b..accessToken = token);
      final response = await openapi.getLoginAPIApi().loginKakao(
        loginRequest: request,
      );

      final accessToken = response.data?.data?.accessToken;
      final refreshToken = response.data?.data?.refreshToken;

      if (accessToken != null && refreshToken != null) {
        return s.TokenResponse(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      } else {
        throw Exception("Login failed. No token returned from server.");
      }
    } on DioException catch (e) {
      // 사용자가 가입 절차를 완료하지 않음
      if (e.response?.statusCode == 404) {
        final email = e.response?.data?["data"]?["email"];
        final domain = e.response?.data?["data"]?["domain"];

        if (email is String && domain is String) {
          throw UserRegisterPendingException(email: email, domain: domain);
        } else {
          throw Exception("Login failed. No email returned");
        }
      }

      rethrow;
    }
  }

  Future<s.TokenResponse> loginWithGoogle({required String token}) async {
    try {
      final request = LoginRequest((b) => b..accessToken = token);

      final response = await openapi.getLoginAPIApi().loginGoogle(
        loginRequest: request,
      );

      final accessToken = response.data?.data?.accessToken;
      final refreshToken = response.data?.data?.refreshToken;

      if (accessToken != null && refreshToken != null) {
        return s.TokenResponse(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      } else {
        throw Exception(
          "Login failed. No access token or refresh token returned",
        );
      }
    } on DioException catch (e) {
      // 사용자가 가입 절차를 완료하지 않음
      if (e.response?.statusCode == 404) {
        final email = e.response?.data?["data"]?["email"];
        final domain = e.response?.data?["data"]?["domain"];

        if (email is String && domain is String) {
          throw UserRegisterPendingException(email: email, domain: domain);
        } else {
          throw Exception("Login failed. No email returned");
        }
      }

      rethrow;
    }
  }

  Future<s.TokenResponse> refreshToken({required String refreshToken}) async {
    throw UnimplementedError();
  }

  Future<void> logout({required String accessToken}) async {
    await openapi.getLoginAPIApi().logout(
      headers: _getAuthorizationHeaders(accessToken),
    );
  }

  Map<String, String> _getAuthorizationHeaders(String accessToken) => {
    "Authorization": "Bearer $accessToken",
  };
}
