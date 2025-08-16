import 'package:data/sources/local/auth_preference.dart';
import 'package:data/sources/server/services/server_api_service.dart';
import 'package:core/common/exception/not_logged_in_exception.dart';
import 'package:dio/dio.dart';

Future<T> callWithAuth<T>({
  required AuthPreference authPreference,
  required ServerApiService serverApiService,
  required Future<T> Function(String aceessToken) action,
}) async {
  try {
    final accessToken = await authPreference.accessToken;
    if (accessToken == null) throw NotLoggedInException();

    return await action(accessToken);
  } on DioException catch (e) {
    if (e.response?.statusCode != 401) rethrow;

    final refreshToken = await authPreference.refreshToken;
    if (refreshToken == null) throw Exception("No refresh token found");

    final response = await serverApiService.refreshToken(
      refreshToken: refreshToken,
    );

    await authPreference.setRefreshToken(response.refreshToken);
    await authPreference.setAccessToken(response.accessToken);

    return await action(response.accessToken);
  }
}
