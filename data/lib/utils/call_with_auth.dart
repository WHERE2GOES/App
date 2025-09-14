import 'package:data/sources/local/auth_preference.dart';
import 'package:core/common/exception/not_logged_in_exception.dart';
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

extension OpenapiExtensions on Openapi {
  Future<T> callWithAuth<T>({
    required AuthPreference authPreference,
    required Future<T> Function(String aceessToken) action,
  }) async {
    try {
      final t = await authPreference.accessToken;
      if (t == null) throw NotLoggedInException();
      return await action(t);
    } on DioException catch (e) {
      if (e.response?.statusCode != 401) rethrow;

      try {
      final rt = await authPreference.refreshToken;
      if (rt == null) throw Exception("No refresh token found");

      final response = await getTokenControllerApi().makeNewToken(body: rt);

      await authPreference.setRefreshToken(response.data!.data!.refreshToken!);
      await authPreference.setAccessToken(response.data!.data!.accessToken!);

      return await action(response.data!.data!.accessToken!);
      } on DioException catch (e) {
        if (e.response?.statusCode != 401) rethrow;

        await authPreference.clear();
        throw NotLoggedInException();
      }
    }
  }
}
