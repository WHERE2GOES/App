import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@named
@lazySingleton
class AuthPreference {
  final SharedPreferencesAsync prefs;

  const AuthPreference({
    @Named.from(SharedPreferencesAsync) required this.prefs,
  });

  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _pendingEmailKey = "pending_email";
  static const String _pendingEmailDomainKey = "pending_email_domain";

  Future<String?> get accessToken => prefs.getString(_accessTokenKey);
  Future<String?> get refreshToken => prefs.getString(_refreshTokenKey);
  Future<String?> get pendingEmail => prefs.getString(_pendingEmailKey);
  Future<String?> get pendingEmailDomain =>
      prefs.getString(_pendingEmailDomainKey);

  Future<void> setAccessToken(String accessToken) =>
      prefs.setString(_accessTokenKey, accessToken);

  Future<void> setRefreshToken(String refreshToken) =>
      prefs.setString(_refreshTokenKey, refreshToken);

  Future<void> setPendingEmail(String? email) async {
    if (email != null) {
      prefs.setString(_pendingEmailKey, email);
    } else {
      prefs.remove(_pendingEmailKey);
    }
  }

  Future<void> setPendingEmailDomain(String? domain) async {
    if (domain != null) {
      prefs.setString(_pendingEmailDomainKey, domain);
    } else {
      prefs.remove(_pendingEmailDomainKey);
    }
  }

  Future<void> clear() async {
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
