import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:core/domain/auth/model/auth_provider.dart';
import 'package:core/domain/user/model/terms_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/models/login_result.dart';
import 'package:login/screens/login_course_preference_end_screen.dart';
import 'package:login/screens/login_course_preference_start_screen.dart';
import 'package:login/screens/login_course_preferences_screen.dart';
import 'package:login/screens/login_personal_info_screen.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/login_terms_agreement_screen.dart';
import 'package:login/screens/login_terms_view_screen.dart';
import 'package:login/util/get_google_access_token.dart';
import 'package:login/util/get_kakao_access_token.dart';
import 'package:login/vms/login_view_model.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({
    super.key,
    required this.vm,
    required this.onLoginSucceeded,
    required this.onBack,
  });

  final LoginViewModel vm;
  final VoidCallback onLoginSucceeded;
  final VoidCallback onBack;

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  Uint8List? _profileImage;
  final _nicknameController = TextEditingController();
  int _currentStep = 0;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return BackButtonListener(
              onBackButtonPressed: () async {
                widget.onBack();
                return true;
              },
              child: ListenableBuilder(
                listenable: widget.vm,
                builder: (context, child) {
                  return switch (settings.name) {
                    "/" => _buildLoginScreen(),
                    "/terms_agreement" => _buildLoginTermsAgreementScreen(),
                    "/terms_view" => _buildLoginTermsViewScreen(
                      termsType: settings.arguments as TermsType,
                    ),
                    "/personal_info" => _buildLoginPersonalInfoScreen(),
                    "/course_preferences_start" =>
                      _buildLoginCoursePreferencesStartScreen(),
                    "/course_preferences" =>
                      _buildLoginCoursePreferencesScreen(),
                    "/course_preference_end" =>
                      _buildLoginCoursePreferenceEndScreen(),
                    _ => throw Exception("Unsupported route"),
                  };
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoginScreen() {
    return LoginScreen(
      onLoginWithKakaoButtonClicked: () =>
          _login(authProvider: AuthProvider.kakao),
      onLoginWithGoogleButtonClicked: () =>
          _login(authProvider: AuthProvider.google),
    );
  }

  Widget _buildLoginTermsAgreementScreen() {
    return LoginTermsAgreementScreen(
      onTermsClicked: _onTermsClicked,
      onAgreeClicked: () {
        // TODO: 현재는 다음 버튼을 누를 시 필수 항목만 동의학고 넘어가는 것으로 간주됨
        for (final termsType in [
          TermsType.termsOfService,
          TermsType.privacyPolicy,
        ]) {
          widget.vm.agreeTerms(termsType: termsType, isAgreed: true);
        }

        _navigatorKey.currentState?.pushReplacementNamed("/personal_info");
      },
    );
  }

  void _onTermsClicked(termsType) {
    widget.vm.loadTermsHtml(termsType: termsType);

    _navigatorKey.currentState?.pushNamed("/terms_view", arguments: termsType);
  }

  Widget _buildLoginTermsViewScreen({required TermsType termsType}) {
    return LoginTermsViewScreen(html: widget.vm.terms?[termsType]?.html);
  }

  Widget _buildLoginPersonalInfoScreen() {
    return LoginPersonalInfoScreen(
      profileImage: _profileImage,
      nicknameController: _nicknameController,
      errorMessage: null,
      onSelectPictureButtonClicked: _onSelectPictureButtonClicked,
      onClearProfileImageButtonClicked: () => _profileImage = null,
      onClearNicknameButtonClicked: () => _nicknameController.clear(),
      onSubmitButtonClicked: () =>
          _navigatorKey.currentState?.pushNamed("/course_preferences_start"),
    );
  }

  Widget _buildLoginCoursePreferencesStartScreen() {
    return LoginCoursePreferencesStartScreen(
      onStartButtonClicked: () {
        widget.vm.loadPreferenceQuestions();
        _navigatorKey.currentState?.pushNamed("/course_preferences");
      },
    );
  }

  Widget _buildLoginCoursePreferencesScreen() {
    final preferenceQuestions = widget.vm.preferenceQuestions;

    return preferenceQuestions != null
        ? LoginCoursePreferencesScreen(
            totalSteps: preferenceQuestions.length,
            step: _currentStep,
            question: preferenceQuestions[_currentStep].question.question,
            options: preferenceQuestions[_currentStep].question.options
                .mapIndexed(
                  (index, e) => (
                    option: e,
                    onClicked: () => _onCoursePreferenceOptionClicked(
                      questionId: preferenceQuestions[_currentStep].question.id,
                      optionIndex: index,
                    ),
                  ),
                )
                .toList(),
            onBackButtonClicked: _back,
            onNextButtonClicked: _onNextPreferenceQuestionButtonClicked,
          )
        : const SizedBox.shrink();
  }

  Widget _buildLoginCoursePreferenceEndScreen() {
    return LoginCoursePreferenceEndScreen(
      backgroundType: widget.vm.coursePreferenceType,
      onGoToNextScreen: widget.onLoginSucceeded,
    );
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
    } else {
      widget.onBack();
    }
  }

  void _login({required AuthProvider authProvider}) async {
    final token = switch (authProvider) {
      AuthProvider.kakao => await getKakaoAccessToken(),
      AuthProvider.google => await getGoogleAccessToken(),
      _ => throw Exception("Unsupported auth provider"),
    };

    final result = await widget.vm.login(
      authProvider: authProvider,
      accessToken: token,
    );

    switch (result) {
      case LoginResult.success:
        widget.onLoginSucceeded();
        break;
      case LoginResult.failure:
        break;
      case LoginResult.needRegister:
        _navigatorKey.currentState?.pushNamed("/terms_agreement");
        break;
    }
  }

  void _onSelectPictureButtonClicked() async {
    // TODO
  }

  void _onCoursePreferenceOptionClicked({
    required int questionId,
    required int optionIndex,
  }) {
    widget.vm.selectPreferenceQuestionOption(
      questionId: questionId,
      optionIndex: optionIndex,
    );

    _onNextPreferenceQuestionButtonClicked();
  }

  void _onNextPreferenceQuestionButtonClicked() async {
    final preferenceQuestions = widget.vm.preferenceQuestions;
    if (preferenceQuestions == null) return;

    if (_currentStep < preferenceQuestions.length - 1) {
      // 아직 질문이 남음
      if (preferenceQuestions[_currentStep].selectedOptionIndex != null) {
        setState(() => _currentStep++);
      }
    } else {
      // 질문이 모두 끝남
      final result = await widget.vm.register(
        profileImage: _profileImage,
        nickname: _nicknameController.text,
      );

      if (result) {
        widget.vm.getCoursePreferenceType();
        _navigatorKey.currentState?.pushNamed("/course_preference_end");
      }
    }
  }
}
