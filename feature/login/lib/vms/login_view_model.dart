import 'dart:typed_data';

import 'package:core/common/result.dart';
import 'package:core/domain/auth/auth_repository.dart';
import 'package:core/domain/auth/model/auth_provider.dart';
import 'package:core/domain/auth/model/auth_token_type.dart';
import 'package:core/domain/user/model/course_preference_type.dart';
import 'package:core/domain/user/model/preference_question_entity.dart';
import 'package:core/domain/user/model/sign_up_request.dart';
import 'package:core/domain/user/model/terms_type.dart';
import 'package:core/domain/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:login/models/login_result.dart';

@lazySingleton
class LoginViewModel extends ChangeNotifier {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  LoginViewModel({required this.authRepository, required this.userRepository});

  Map<TermsType, ({String html, bool isAgreed})?> terms = {
    for (final termsType in TermsType.values) termsType: null,
  };
  List<({PreferenceQuestionEntity question, int? selectedOptionIndex})>?
  preferenceQuestions;

  CoursePreferenceType? coursePreferenceType;

  Future<LoginResult> login({
    required AuthProvider authProvider,
    required String accessToken,
  }) async {
    final result = await authRepository.login(
      authProvider: authProvider,
      authTokenType: AuthTokenType.bearer,
      accessToken: accessToken,
      idToken: null,
    );

    if (result is Success<bool>) {
      return result.data ? LoginResult.success : LoginResult.needRegister;
    } else {
      return LoginResult.failure;
    }
  }

  Future<void> loadPreferenceQuestions() async {
    preferenceQuestions = null;
    notifyListeners();

    final result = await userRepository.getPreferenceQuestions();

    if (result is Success<List<PreferenceQuestionEntity>>) {
      preferenceQuestions = result.data
          .map((e) => (question: e, selectedOptionIndex: null))
          .toList();
      notifyListeners();
    }
  }

  Future<void> loadTermsHtml({required TermsType termsType}) async {
    terms[termsType] = null;
    notifyListeners();

    final result = await userRepository.getTermsHtml(termsType: termsType);

    if (result is Success<String>) {
      terms[termsType] = (html: result.data, isAgreed: false);
      notifyListeners();
    }
  }

  Future<void> agreeTerms({
    required TermsType termsType,
    required bool isAgreed,
  }) async {
    final terms = this.terms[termsType];
    if (terms == null) return;
    this.terms[termsType] = (html: terms.html, isAgreed: isAgreed);
    notifyListeners();
  }

  Future<void> selectPreferenceQuestionOption({
    required int questionId,
    required int optionIndex,
  }) async {
    preferenceQuestions = preferenceQuestions
        ?.map(
          (e) => e.question.id == questionId
              ? (question: e.question, selectedOptionIndex: optionIndex)
              : e,
        )
        .toList();
    notifyListeners();
  }

  Future<bool> register({
    required Uint8List? profileImage,
    required String nickname,
  }) async {
    try {
      final result = await userRepository.signUp(
        request: SignUpRequest(
          nickname: nickname,
          preferences:
              preferenceQuestions! // can cause type error
                  .map(
                    (e) => (
                      questionId: e.question.id,
                      selectedOptionIndex:
                          e.selectedOptionIndex!, // can cause type error
                    ),
                  )
                  .toList(),
          agreedTerms: terms.entries
              .where((e) => e.value?.isAgreed ?? false)
              .map((e) => e.key)
              .toList(),
        ),
      );

      return result is Success;
    } on TypeError catch (_) {
      return false;
    }
  }

  Future<void> getCoursePreferenceType() async {
    final result = await userRepository.getCoursePreferenceType();

    if (result is Success<CoursePreferenceType>) {
      coursePreferenceType = result.data;
      notifyListeners();
    }
  }
}
