import 'package:get/get.dart';

class UserModel {
  final RxInt level = 1.obs;
  final RxInt xp = 0.obs;
  final RxInt energy = 25.obs;
  final RxInt maxEnergy = 25.obs;
  final RxInt streak = 0.obs;
  final RxMap<String, double> progress = <String, double>{}.obs;
  final RxList<String> completedTasks = <String>[].obs;
  final RxList<String> achievements = <String>[].obs;

  // Синглтон
  static final UserModel _instance = UserModel._internal();

  factory UserModel() {
    return _instance;
  }

  UserModel._internal() {
    // Инициализация начальных значений
    progress.value = {
      "TypeScript": 0.6,
      "JavaScript Основы": 0.8,
      "React": 0.4,
      "SQL": 0.6,
      "Паттерны проектирования": 0.2,
    };
  }

  // Методы для обновления данных пользователя

  void addXP(int amount) {
    xp.value += amount;
    _checkLevelUp();
  }

  void _checkLevelUp() {
    // Простая формула для определения уровня: каждые 500 XP = новый уровень
    int newLevel = (xp.value / 500).floor() + 1;
    if (newLevel > level.value) {
      level.value = newLevel;
      // Увеличиваем максимальную энергию при повышении уровня
      maxEnergy.value += 5;
      energy.value =
          maxEnergy.value; // Восстанавливаем энергию при повышении уровня
    }
  }

  bool useEnergy(int amount) {
    if (energy.value >= amount) {
      energy.value -= amount;
      return true;
    }
    return false;
  }

  void addEnergy(int amount) {
    energy.value = (energy.value + amount).clamp(0, maxEnergy.value);
  }

  void incrementStreak() {
    streak.value++;
  }

  void resetStreak() {
    streak.value = 0;
  }

  void updateProgress(String category, double value) {
    progress[category] = value;
    progress.refresh();
  }

  void completeTask(String taskId) {
    if (!completedTasks.contains(taskId)) {
      completedTasks.add(taskId);
    }
  }

  void unlockAchievement(String achievementId) {
    if (!achievements.contains(achievementId)) {
      achievements.add(achievementId);
    }
  }

  // Геттеры для получения данных

  int get currentLevel => level.value;

  int get currentXP => xp.value;

  int get xpToNextLevel => (level.value * 500) - xp.value;

  int get currentEnergy => energy.value;

  int get currentMaxEnergy => maxEnergy.value;

  int get currentStreak => streak.value;

  double getProgressForCategory(String category) {
    return progress[category] ?? 0.0;
  }

  bool isTaskCompleted(String taskId) {
    return completedTasks.contains(taskId);
  }

  bool hasAchievement(String achievementId) {
    return achievements.contains(achievementId);
  }

  // Метод для восстановления энергии (может вызываться по таймеру)
  void regenerateEnergy() {
    if (energy.value < maxEnergy.value) {
      energy.value++;
    }
  }
}
