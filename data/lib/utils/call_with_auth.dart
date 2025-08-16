import 'package:data/sources/local/auth_preference.dart';
import 'package:data/sources/server/services/server_api_service.dart';

Future<T> callWithAuth<T>({
  required AuthPreference authPreference,
  required ServerApiService serverApiService,
  required Future<T> Function(String aceessToken) action,
}) async {
  try {
    final accessToken = await authPreference.accessToken;
    if (accessToken == null) throw Exception("No access token found");
    return await action(accessToken);
  } catch (e) {
    final refreshToken = await authPreference.refreshToken;
    if (refreshToken == null) throw Exception("No refresh token found");
    // TODO: 토큰 재발급
    final accessToken = await authPreference.accessToken;
    if (accessToken == null) throw Exception("No access token found");
    return await action(accessToken);
  }
}
