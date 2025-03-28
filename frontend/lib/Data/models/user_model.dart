class User {
  final String id;
  final String name;
  final String email;
  final String avatarInitials;
  final int energy;
  final int xp;
  final int level;
  final String levelTitle;
  final Map<String, UserCourseProgress> coursesProgress;
  final List<Achievement> achievements;
  final List<DailyChallenge> dailyChallenges;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarInitials,
    required this.energy,
    required this.xp,
    required this.level,
    required this.levelTitle,
    required this.coursesProgress,
    required this.achievements,
    required this.dailyChallenges,
  });

  // Вычисляемые свойства
  double get totalCoursesProgress {
    if (coursesProgress.isEmpty) return 0.0;
    
    double totalProgress = 0;
    coursesProgress.forEach((_, progress) {
      totalProgress += progress.percentComplete;
    });
    
    return totalProgress / coursesProgress.length;
  }

  // Обновление энергии
  User copyWithEnergy(int newEnergy) {
    return User(
      id: id,
      name: name,
      email: email,
      avatarInitials: avatarInitials,
      energy: newEnergy,
      xp: xp,
      level: level,
      levelTitle: levelTitle,
      coursesProgress: coursesProgress,
      achievements: achievements,
      dailyChallenges: dailyChallenges,
    );
  }

  // Обновление опыта
  User copyWithXP(int additionalXP) {
    return User(
      id: id,
      name: name,
      email: email,
      avatarInitials: avatarInitials,
      energy: energy,
      xp: xp + additionalXP,
      level: level,
      levelTitle: levelTitle,
      coursesProgress: coursesProgress,
      achievements: achievements,
      dailyChallenges: dailyChallenges,
    );
  }

  // Обновление прогресса курса
  User updateCourseProgress(String courseId, UserCourseProgress newProgress) {
    final updatedProgress = Map<String, UserCourseProgress>.from(coursesProgress);
    updatedProgress[courseId] = newProgress;
    
    return User(
      id: id,
      name: name,
      email: email,
      avatarInitials: avatarInitials,
      energy: energy,
      xp: xp,
      level: level,
      levelTitle: levelTitle,
      coursesProgress: updatedProgress,
      achievements: achievements,
      dailyChallenges: dailyChallenges,
    );
  }

  // Фабричный метод для создания тестового пользователя
  factory User.createDefault() {
    return User(
      id: "user1",
      name: "Александр Ганяк",
      email: "alex@example.com",
      avatarInitials: "АГ",
      energy: 25,
      xp: 450,
      level: 5,
      levelTitle: "Начинающий разработчик",
      coursesProgress: {
        "junior-frontend": UserCourseProgress(
          courseId: "junior-frontend",
          completedModules: 2,
          totalModules: 6,
          completedLessons: 12,
          totalLessons: 24,
          percentComplete: 0.35,
          lastAccessedModuleId: "module-3",
          completedTasks: ["task1", "task2", "task3", "task4", "task5"],
        ),
        "junior-backend-django": UserCourseProgress(
          courseId: "junior-backend-django",
          completedModules: 1,
          totalModules: 6,
          completedLessons: 6,
          totalLessons: 24,
          percentComplete: 0.2,
          lastAccessedModuleId: "module-2",
          completedTasks: ["task1", "task2"],
        ),
      },
      achievements: [
        Achievement(
          id: "algo-starter",
          title: "Алгоритмический старт",
          description: "Решите 5 алгоритмических задач",
          currentProgress: 3,
          targetProgress: 5,
          iconPath: "assets/icons/algorithm.png",
          isCompleted: false,
        ),
        Achievement(
          id: "js-master",
          title: "JavaScript мастер",
          description: "Пройдите все тесты по JavaScript",
          currentProgress: 8,
          targetProgress: 10,
          iconPath: "assets/icons/javascript.png",
          isCompleted: false,
        ),
      ],
      dailyChallenges: [
        DailyChallenge(
          id: "daily-tasks",
          title: "Решите 3 задачи",
          reward: "50 XP",
          currentProgress: 1,
          targetProgress: 3,
          iconPath: "assets/icons/challenge.png",
          isCompleted: false,
        ),
        DailyChallenge(
          id: "react-test",
          title: "Пройдите тест по React",
          reward: "30 XP + 2 энергии",
          currentProgress: 0,
          targetProgress: 1,
          iconPath: "assets/icons/react.png",
          isCompleted: false,
        ),
      ],
    );
  }
}

class UserCourseProgress {
  final String courseId;
  final int completedModules;
  final int totalModules;
  final int completedLessons;
  final int totalLessons;
  final double percentComplete;
  final String lastAccessedModuleId;
  final List<String> completedTasks;

  UserCourseProgress({
    required this.courseId,
    required this.completedModules,
    required this.totalModules,
    required this.completedLessons,
    required this.totalLessons,
    required this.percentComplete,
    required this.lastAccessedModuleId,
    required this.completedTasks,
  });

  // Getter for completedTasksIds (alias for completedTasks)
  List<String> get completedTasksIds => completedTasks;
  
  // Getter for completionPercentage (alias for percentComplete)
  double get completionPercentage => percentComplete;

  // Обновление прогресса курса
  UserCourseProgress addCompletedTask(String taskId) {
    final updatedTasks = List<String>.from(completedTasks);
    if (!updatedTasks.contains(taskId)) {
      updatedTasks.add(taskId);
    }
    
    return UserCourseProgress(
      courseId: courseId,
      completedModules: completedModules,
      totalModules: totalModules,
      completedLessons: completedLessons,
      totalLessons: totalLessons,
      percentComplete: percentComplete,
      lastAccessedModuleId: lastAccessedModuleId,
      completedTasks: updatedTasks,
    );
  }

  // Обновление последнего доступного модуля
  UserCourseProgress updateLastAccessedModule(String moduleId) {
    return UserCourseProgress(
      courseId: courseId,
      completedModules: completedModules,
      totalModules: totalModules,
      completedLessons: completedLessons,
      totalLessons: totalLessons,
      percentComplete: percentComplete,
      lastAccessedModuleId: moduleId,
      completedTasks: completedTasks,
    );
  }
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final int currentProgress;
  final int targetProgress;
  final String iconPath;
  final bool isCompleted;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.currentProgress,
    required this.targetProgress,
    required this.iconPath,
    required this.isCompleted,
  });

  double get progressPercentage => currentProgress / targetProgress;

  Achievement updateProgress(int newProgress) {
    final updatedIsCompleted = newProgress >= targetProgress;
    
    return Achievement(
      id: id,
      title: title,
      description: description,
      currentProgress: newProgress,
      targetProgress: targetProgress,
      iconPath: iconPath,
      isCompleted: updatedIsCompleted,
    );
  }
}

class DailyChallenge {
  final String id;
  final String title;
  final String reward;
  final int currentProgress;
  final int targetProgress;
  final String iconPath;
  final bool isCompleted;

  DailyChallenge({
    required this.id,
    required this.title,
    required this.reward,
    required this.currentProgress,
    required this.targetProgress,
    required this.iconPath,
    required this.isCompleted,
  });

  double get progressPercentage => currentProgress / targetProgress;

  DailyChallenge updateProgress(int newProgress) {
    final updatedIsCompleted = newProgress >= targetProgress;
    
    return DailyChallenge(
      id: id,
      title: title,
      reward: reward,
      currentProgress: newProgress,
      targetProgress: targetProgress,
      iconPath: iconPath,
      isCompleted: updatedIsCompleted,
    );
  }
} 