import 'package:data/sources/local/auth_preference.dart';
import 'package:core/common/exception/not_logged_in_exception.dart';
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

extension OpenapiExtensions on AuthPreference {
  Future<T> callWithAuth<T>({
    required Openapi openapi,
    required Future<T> Function(String aceessToken) action,
  }) async {
    try {
      final t = await accessToken;
      if (t == null) throw NotLoggedInException();
      return await action(t);
    } on DioException catch (e) {
      if (e.response?.statusCode != 401) rethrow;

      final rt = await refreshToken;
      if (rt == null) throw Exception("No refresh token found");

      final response = await openapi.getTokenControllerApi().makeNewToken(
        body: rt,
      );

      setRefreshToken(response.data!.data!.refreshToken!);
      setAccessToken(response.data!.data!.accessToken!);

      return await action(response.data!.data!.accessToken!);
    }
  }
}
