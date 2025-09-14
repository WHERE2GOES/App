import 'package:core/common/result.dart' show Success;
import 'package:core/domain/course/model/current_course_entity.dart';
import 'package:core/domain/reward/model/certificate_entity.dart';
import 'package:core/domain/reward/model/owned_reward_entity.dart';
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

  CurrentCourseEntity? currentCourse;
  List<CertificateEntity>? certificates;

  Future<void> getCertificates() async {
    currentCourse = null;
    certificates = null;
    notifyListeners();

    final current = await courseRepository.getCurrentCourse();

    if (current is Success<CurrentCourseEntity?>) {
      currentCourse = current.data;
      notifyListeners();
    } else {
      return;
    }

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

  Future<OwnedRewardEntity> getDownloadUrl() async {
    final result = await rewardRepository.getOwnedRewards();

    if (result is Success<List<OwnedRewardEntity>>) {
      return result.data.firstWhere((e) => e.courseId == currentCourse!.id);
    } else {
      throw Exception("Failed to get download URL");
    }
  }
}
