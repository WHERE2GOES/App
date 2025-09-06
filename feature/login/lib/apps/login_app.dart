import 'package:core/common/result.dart';
import 'package:core/domain/auth/auth_repository.dart';
import 'package:core/domain/auth/model/auth_provider.dart';
import 'package:core/domain/auth/model/auth_token_type.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login/screens/login_screen.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key, required this.onLoginSucceeded});

  final VoidCallback onLoginSucceeded;

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final _authRepository = GetIt.I<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      onLoginWithKakaoButtonClicked: _loginWithKakao,
      onLoginWithGoogleButtonClicked: _loginWithGoogle,
    );
  }

  void _loginWithKakao() async {
    final token = await _getKakaoAccessToken();

    final result = await _authRepository.login(
      authProvider: AuthProvider.kakao,
      authTokenType: AuthTokenType.bearer,
      accessToken: token.accessToken,
      idToken: null,
    );

    if (result is Success) {
      widget.onLoginSucceeded();
    }
  }

  void _loginWithGoogle() async {
    const scopes = ['email'];

    final user = await GoogleSignIn.instance.authenticate(scopeHint: scopes);
    final auth = await user.authorizationClient.authorizationForScopes(scopes);

    final accessToken = auth?.accessToken;
    if (accessToken == null) {
      throw Exception("Google login failed. Access token not arrived.");
    }

    final result = await _authRepository.login(
      authProvider: AuthProvider.google,
      authTokenType: AuthTokenType.bearer,
      accessToken: accessToken,
      idToken: null,
    );

    if (result is Success) {
      widget.onLoginSucceeded();
    }
  }

  Future<OAuthToken> _getKakaoAccessToken() async {
    try {
      return await UserApi.instance.loginWithKakaoTalk();
    } catch (e) {
      return await UserApi.instance.loginWithKakaoAccount();
    }
  }
}
