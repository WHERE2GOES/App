import 'package:core/domain/reward/reward_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RewardViewModel extends ChangeNotifier {
  final RewardRepository rewardRepository;

  RewardViewModel(this.rewardRepository);

  
}
