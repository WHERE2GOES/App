import 'package:core/common/result.dart' show Success;
import 'package:core/domain/auth/auth_repository.dart';
import 'package:core/domain/user/model/terms_type.dart';
import 'package:core/domain/user/model/user_entity.dart';
import 'package:core/domain/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MyPageViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  MyPageViewModel({required this.userRepository, required this.authRepository});

  UserEntity? user;
  Map<TermsType, String?> termsHtml = {
    for (final termsType in TermsType.values) termsType: null,
  };

  Future<void> loadUser() async {
    user = null;
    notifyListeners();

    final result = await userRepository.getUserInfo();

    if (result is Success<UserEntity>) {
      user = result.data;
      notifyListeners();
    }
  }

  Future<void> loadTermsHtml({required TermsType termsType}) async {
    termsHtml[termsType] = null;
    notifyListeners();

    final result = await userRepository.getTermsHtml(termsType: termsType);

    if (result is Success<String>) {
      termsHtml[termsType] = result.data;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final result = await authRepository.logout();

    if (result is Success<void>) {
      user = null;
      notifyListeners();
    }
  }
}
