import 'package:get/get.dart';
import 'package:devup/Data/user_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class GamificationController extends GetxController {
  final UserModel _userModel = UserModel();
  
  // Синглтон
  static final GamificationController _instance = GamificationController._internal();
  
  factory GamificationController() {
    return _instance;
  }
  
  GamificationController._internal();
  
  // Методы для управления геймификацией
  
  // Метод для завершения задания
  void completeTask(String taskId, int xpReward, {bool isCorrect = true}) {
    // Если ответ неверный, даем только половину XP
    int actualXP = isCorrect ? xpReward : (xpReward ~/ 2);
    
    _userModel.addXP(actualXP);
    _userModel.completeTask(taskId);
    
    // Проверяем достижения
    _checkAchievements();
    
    // Показываем уведомление о получении XP
    _showXPNotification(actualXP);
  }
  
  // Метод для использования энергии
  bool useEnergy(int amount) {
    return _userModel.useEnergy(amount);
  }
  
  // Метод для добавления энергии
  void addEnergy(int amount) {
    _userModel.addEnergy(amount);
  }
  
  // Метод для обновления прогресса в категории
  void updateProgress(String category, double value) {
    _userModel.updateProgress(category, value);
  }
  
  // Метод для увеличения серии дней
  void incrementStreak() {
    _userModel.incrementStreak();
    
    // Даем бонус за серию дней
    int streak = _userModel.currentStreak;
    if (streak % 7 == 0) {
      // Каждые 7 дней даем бонус
      _userModel.addXP(100);
      _userModel.addEnergy(5);
      _showStreakBonusNotification(streak);
    }
  }
  
  // Метод для проверки достижений
  void _checkAchievements() {
    // Проверяем достижение "Алгоритмический старт"
    int algorithmTasksCompleted = 0;
    // Здесь должна быть логика подсчета выполненных алгоритмических задач
    if (algorithmTasksCompleted >= 5 && !_userModel.hasAchievement("algorithm_start")) {
      _userModel.unlockAchievement("algorithm_start");
      _showAchievementNotification("Алгоритмический старт");
    }
    
    // Проверяем другие достижения
    // ...
  }
  
  // Метод для показа уведомления о получении XP
  void _showXPNotification(int xp) {
    Get.snackbar(
      "Получено $xp XP",
      "Продолжайте в том же духе!",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }
  
  // Метод для показа уведомления о бонусе за серию дней
  void _showStreakBonusNotification(int streak) {
    Get.snackbar(
      "Серия $streak дней!",
      "Получен бонус: 100 XP и 5 энергии",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }
  
  // Метод для показа уведомления о достижении
  void _showAchievementNotification(String achievementName) {
    Get.snackbar(
      "Новое достижение!",
      achievementName,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }
  
  // Геттеры для получения данных пользователя
  
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
  
  // Метод для запуска таймера восстановления энергии
  void startEnergyRegenerationTimer() {
    // Восстанавливаем 1 энергию каждые 30 минут
    Timer.periodic(Duration(minutes: 30), (_) {
      _userModel.regenerateEnergy();
    });
  }
} 