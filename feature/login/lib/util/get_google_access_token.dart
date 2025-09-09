import 'package:google_sign_in/google_sign_in.dart';

Future<String> getGoogleAccessToken() async {
  const scopes = ['email'];

  final user = await GoogleSignIn.instance.authenticate(scopeHint: scopes);
  final auth = await user.authorizationClient.authorizationForScopes(scopes);

  final accessToken = auth?.accessToken;
  if (accessToken == null) {
    throw Exception("Google login failed. Access token not arrived.");
  }

  return accessToken;
}
