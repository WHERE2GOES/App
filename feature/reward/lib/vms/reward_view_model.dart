import 'package:core/common/result.dart' show Success;
import 'package:core/domain/course/model/current_course_entity.dart';
import 'package:core/domain/reward/model/certificate_entity.dart';
import 'package:core/domain/reward/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:core/domain/course/course_repository.dart';

@lazySingleton
class RewardViewModel extends ChangeNotifier {
  final RewardRepository rewardRepository;
  final CourseRepository courseRepository;

  RewardViewModel({
    required this.rewardRepository,
    required this.courseRepository,
  });

  bool? isCourseInProgress;
  List<CertificateEntity>? certificates;

  Future<void> getCertificates() async {
    isCourseInProgress = null;
    notifyListeners();

    final current = await courseRepository.getCurrentCourse();

    isCourseInProgress =
        current is Success<CurrentCourseEntity?> && current.data != null;
    notifyListeners();

    final result = await rewardRepository.getCertificates();

    if (result is Success<List<CertificateEntity>>) {
      certificates = result.data;
      notifyListeners();
    }
  }

  Future<bool> authenticateCertificate({
    required int certificateId,
    required String qrCode,
  }) async {
    final result = await rewardRepository.authenticateCertificate(
      certificateId: certificateId,
      qrCode: qrCode,
    );

    if (result is Success<void>) {
      getCertificates();
      return true;
    } else {
      return false;
    }
  }
}
