import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/course_model.dart';
import '../models/task_model.dart';
import '../models/module_model.dart';
import '../models/lesson_model.dart';

// Сервис для хранения и управления всеми данными приложения
class DataService extends GetxService {
  // Синглтон
  static DataService get to => Get.find<DataService>();
  
  // Текущий пользователь
  final Rx<User> _currentUser = User.createDefault().obs;
  User get currentUser => _currentUser.value;
  
  // Список курсов
  final RxList<Course> _courses = <Course>[].obs;
  List<Course> get courses => _courses;
  
  // Список задач
  final RxList<Task> _tasks = <Task>[].obs;
  List<Task> get tasks => _tasks;
  
  // Инициализация сервиса
  Future<DataService> init() async {
    print("DataService: Starting initialization");
    
    // Загрузка данных пользователя
    // В реальном приложении здесь был бы запрос к API или базе данных
    _currentUser.value = User.createDefault();
    print("DataService: User loaded");
    
    // Загрузка курсов
    _courses.value = Course.getAllCourses();
    print("DataService: Loaded ${_courses.length} courses: ${_courses.map((c) => c.id).toList()}");
    
    // Загрузка задач
    _tasks.value = TaskRepository.getAllTasks();
    print("DataService: Loaded ${_tasks.length} tasks");
    
    return this;
  }
  
  // Методы для работы с пользователем
  
  // Обновление энергии пользователя
  void updateUserEnergy(int newEnergy) {
    _currentUser.value = _currentUser.value.copyWithEnergy(newEnergy);
    _currentUser.refresh();
  }
  
  // Добавление опыта пользователю
  void addUserXP(int xp) {
    _currentUser.value = _currentUser.value.copyWithXP(xp);
    _currentUser.refresh();
  }
  
  // Обновление прогресса курса
  void updateCourseProgress(String courseId, UserCourseProgress progress) {
    _currentUser.value = _currentUser.value.updateCourseProgress(courseId, progress);
    _currentUser.refresh();
  }
  
  // Отметить задание как выполненное
  void markTaskAsCompleted(String courseId, String taskId, int xpReward) {
    // Получаем текущий прогресс курса
    final courseProgress = _currentUser.value.coursesProgress[courseId];
    if (courseProgress == null) return;
    
    // Обновляем прогресс курса
    final updatedProgress = courseProgress.addCompletedTask(taskId);
    updateCourseProgress(courseId, updatedProgress);
    
    // Добавляем опыт пользователю
    addUserXP(xpReward);
  }
  
  // Методы для работы с курсами
  
  // Получение курса по ID
  Course? getCourseById(String id) {
    print("DataService: Searching for course with ID: $id");
    print("DataService: Available courses: ${_courses.map((c) => '${c.id}: ${c.title}').toList()}");
    
    try {
      final course = _courses.firstWhere((course) => course.id == id);
      print("DataService: Found course: ${course.title}");
      return course;
    } catch (e) {
      print("DataService: Course not found with ID: $id, Error: $e");
      
      // Попробуем загрузить курсы еще раз, если список пуст
      if (_courses.isEmpty) {
        print("DataService: Course list is empty, trying to reload");
        _courses.value = Course.getAllCourses();
        
        // Повторная попытка
        try {
          final course = _courses.firstWhere((course) => course.id == id);
          print("DataService: Found course after reload: ${course.title}");
          return course;
        } catch (e) {
          print("DataService: Course still not found after reload: $e");
          return null;
        }
      }
      
      return null;
    }
  }
  
  // Получение курсов по уровню
  List<Course> getCoursesByLevel(String level) {
    return _courses.where((course) => course.level == level).toList();
  }
  
  // Получение курсов по технологии
  List<Course> getCoursesByTechnology(String technology) {
    return _courses.where((course) => course.technology == technology).toList();
  }
  
  // Методы для работы с задачами
  
  // Получение задачи по ID
  Task? getTaskById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Получение задач по треку (направлению)
  List<Task> getTasksByTrack(String track) {
    return _tasks.where((task) => task.track == track).toList();
  }
  
  // Получение задач по типу
  List<Task> getTasksByType(String type) {
    return _tasks.where((task) => task.type == type).toList();
  }
  
  // Получение задач по уровню сложности
  List<Task> getTasksByDifficulty(String difficulty) {
    return _tasks.where((task) => task.difficulty == difficulty).toList();
  }
  
  // Получение задач по категории
  List<Task> getTasksByCategory(String category) {
    return _tasks.where((task) => task.category == category).toList();
  }
  
  // Получение задач для определенного модуля курса
  List<Task> getTasksForModule(Course course, Module module) {
    final List<Task> moduleTasks = [];
    
    for (final lesson in module.lessons) {
      if (lesson.type == LessonType.task && lesson.taskId != null) {
        final task = getTaskById(lesson.taskId!);
        if (task != null) {
          moduleTasks.add(task);
        }
      }
    }
    
    return moduleTasks;
  }
  
  // Обновление достижений пользователя
  void updateAchievement(String achievementId, int progress) {
    final List<Achievement> updatedAchievements = [];
    
    for (final achievement in _currentUser.value.achievements) {
      if (achievement.id == achievementId) {
        updatedAchievements.add(achievement.updateProgress(progress));
      } else {
        updatedAchievements.add(achievement);
      }
    }
    
    _currentUser.value = User(
      id: _currentUser.value.id,
      name: _currentUser.value.name,
      email: _currentUser.value.email,
      avatarInitials: _currentUser.value.avatarInitials,
      energy: _currentUser.value.energy,
      xp: _currentUser.value.xp,
      level: _currentUser.value.level,
      levelTitle: _currentUser.value.levelTitle,
      coursesProgress: _currentUser.value.coursesProgress,
      achievements: updatedAchievements,
      dailyChallenges: _currentUser.value.dailyChallenges,
    );
    
    _currentUser.refresh();
  }
  
  // Обновление ежедневных заданий
  void updateDailyChallenge(String challengeId, int progress) {
    final List<DailyChallenge> updatedChallenges = [];
    
    for (final challenge in _currentUser.value.dailyChallenges) {
      if (challenge.id == challengeId) {
        updatedChallenges.add(challenge.updateProgress(progress));
      } else {
        updatedChallenges.add(challenge);
      }
    }
    
    _currentUser.value = User(
      id: _currentUser.value.id,
      name: _currentUser.value.name,
      email: _currentUser.value.email,
      avatarInitials: _currentUser.value.avatarInitials,
      energy: _currentUser.value.energy,
      xp: _currentUser.value.xp,
      level: _currentUser.value.level,
      levelTitle: _currentUser.value.levelTitle,
      coursesProgress: _currentUser.value.coursesProgress,
      achievements: _currentUser.value.achievements,
      dailyChallenges: updatedChallenges,
    );
    
    _currentUser.refresh();
  }
} 