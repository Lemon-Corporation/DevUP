import 'dart:async';

import 'package:devup/Data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamificationController extends GetxController {
  final UserModel _userModel = UserModel();

  static final GamificationController _instance =
      GamificationController._internal();

  factory GamificationController() {
    return _instance;
  }

  GamificationController._internal();

  void completeTask(String taskId, int xpReward, {bool isCorrect = true}) {
    int actualXP = isCorrect ? xpReward : (xpReward ~/ 2);

    _userModel.addXP(actualXP);
    _userModel.completeTask(taskId);

    _checkAchievements();

    _showXPNotification(actualXP);
  }

  bool useEnergy(int amount) {
    return _userModel.useEnergy(amount);
  }

  void addEnergy(int amount) {
    _userModel.addEnergy(amount);
  }

  void updateProgress(String category, double value) {
    _userModel.updateProgress(category, value);
  }

  void incrementStreak() {
    _userModel.incrementStreak();

    int streak = _userModel.currentStreak;
    if (streak % 7 == 0) {
      _userModel.addXP(100);
      _userModel.addEnergy(5);
      _showStreakBonusNotification(streak);
    }
  }

  void _checkAchievements() {
    int algorithmTasksCompleted = 0;
    if (algorithmTasksCompleted >= 5 &&
        !_userModel.hasAchievement("algorithm_start")) {
      _userModel.unlockAchievement("algorithm_start");
      _showAchievementNotification("Алгоритмический старт");
    }
  }

  void _showXPNotification(int xp) {
    Get.snackbar(
      "Получено $xp XP",
      "Продолжайте в том же духе!",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  void _showStreakBonusNotification(int streak) {
    Get.snackbar(
      "Серия $streak дней!",
      "Получен бонус: 100 XP и 5 энергии",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }

  void _showAchievementNotification(String achievementName) {
    Get.snackbar(
      "Новое достижение!",
      achievementName,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }

  int get level => _userModel.currentLevel;

  int get xp => _userModel.currentXP;

  int get xpToNextLevel => _userModel.xpToNextLevel;

  int get energy => _userModel.currentEnergy;

  int get maxEnergy => _userModel.currentMaxEnergy;

  int get streak => _userModel.currentStreak;

  double getProgressForCategory(String category) {
    return _userModel.getProgressForCategory(category);
  }

  bool isTaskCompleted(String taskId) {
    return _userModel.isTaskCompleted(taskId);
  }

  bool hasAchievement(String achievementId) {
    return _userModel.hasAchievement(achievementId);
  }

  void startEnergyRegenerationTimer() {
    Timer.periodic(Duration(minutes: 30), (_) {
      _userModel.regenerateEnergy();
    });
  }
}
