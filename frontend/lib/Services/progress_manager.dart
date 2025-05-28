import 'package:devup/Data/js_test_data.dart';

// Класс для управления прогрессом пользователя
class ProgressManager {
  static const String _progressKey = 'user_progress';
  static const String _xpKey = 'user_xp';
  static const String _completedTestsKey = 'completed_tests';
  static const String _completedLessonsKey = 'completed_lessons'; // Новый ключ для уроков
  
  // Симуляция локального хранилища (в реальном приложении используйте SharedPreferences)
  static Map<String, dynamic> _localStorage = {
    _progressKey: 0.35, // 35% начальный прогресс
    _xpKey: 450, // начальный XP
    _completedTestsKey: <String>[],
    _completedLessonsKey: <String>[], // Новый список для уроков
  };
  
  // Получить текущий прогресс (0.0 - 1.0)
  static double getCurrentProgress() {
    return _localStorage[_progressKey] ?? 0.0;
  }
  
  // Получить текущий XP
  static int getCurrentXP() {
    return _localStorage[_xpKey] ?? 0;
  }
  
  // Получить список завершенных тестов
  static List<String> getCompletedTests() {
    return List<String>.from(_localStorage[_completedTestsKey] ?? []);
  }
  
  // Получить список завершенных уроков
  static List<String> getCompletedLessons() {
    return List<String>.from(_localStorage[_completedLessonsKey] ?? []);
  }
  
  // Проверить, завершен ли тест
  static bool isTestCompleted(String testId) {
    return getCompletedTests().contains(testId);
  }
  
  // Проверить, завершен ли урок
  static bool isLessonCompleted(String lessonId) {
    return getCompletedLessons().contains(lessonId);
  }
  
  // Отметить урок как завершенный
  static void completeLesson(String lessonId, {int xpReward = 10}) {
    final completedLessons = getCompletedLessons();
    
    if (!completedLessons.contains(lessonId)) {
      // Добавляем урок в список завершенных
      completedLessons.add(lessonId);
      _localStorage[_completedLessonsKey] = completedLessons;
      
      // Увеличиваем XP
      final currentXP = getCurrentXP();
      _localStorage[_xpKey] = currentXP + xpReward;
      
      // Обновляем прогресс (каждый урок добавляет определенный процент)
      final progressIncrement = _getLessonProgressIncrement(lessonId);
      final currentProgress = getCurrentProgress();
      final newProgress = (currentProgress + progressIncrement).clamp(0.0, 1.0);
      _localStorage[_progressKey] = newProgress;
      
      print('Урок $lessonId завершен! +$xpReward XP. Прогресс: ${(newProgress * 100).round()}%');
    }
  }
  
  // Отметить тест как завершенный и обновить прогресс
  static void completeTest(String testId, int xpReward) {
    final completedTests = getCompletedTests();
    
    if (!completedTests.contains(testId)) {
      // Добавляем тест в список завершенных
      completedTests.add(testId);
      _localStorage[_completedTestsKey] = completedTests;
      
      // Увеличиваем XP
      final currentXP = getCurrentXP();
      _localStorage[_xpKey] = currentXP + xpReward;
      
      // Обновляем прогресс (каждый тест добавляет определенный процент)
      final progressIncrement = _getProgressIncrement(testId);
      final currentProgress = getCurrentProgress();
      final newProgress = (currentProgress + progressIncrement).clamp(0.0, 1.0);
      _localStorage[_progressKey] = newProgress;
      
      print('Тест $testId завершен! +$xpReward XP. Прогресс: ${(newProgress * 100).round()}%');
    }
  }
  
  // Получить прирост прогресса для конкретного урока
  static double _getLessonProgressIncrement(String lessonId) {
    switch (lessonId) {
      // Модуль 3 уроки
      case 'objects_theory':
        return 0.03; // 3%
      case 'arrays_theory':
        return 0.03; // 3%
      case 'destructuring_theory':
        return 0.03; // 3%
      // Модуль 2 уроки
      case 'functions_theory':
        return 0.03; // 3%
      case 'closures_theory':
        return 0.03; // 3%
      // Модуль 1 уроки (уже завершены)
      case 'intro_js':
        return 0.02; // 2%
      case 'variables_types':
        return 0.02; // 2%
      case 'operators_expressions':
        return 0.02; // 2%
      default:
        return 0.02; // 2% для других уроков
    }
  }
  
  // Получить прирост прогресса для конкретного теста
  static double _getProgressIncrement(String testId) {
    switch (testId) {
      case 'js_variables_test':
        return 0.08; // 8%
      case 'js_operators_test':
        return 0.08; // 8%
      case 'js_variables_code':
        return 0.12; // 12%
      case 'js_operators_code':
        return 0.12; // 12%
      case 'calculator_project':
        return 0.25; // 25%
      // Модуль 3 тесты
      case 'js_objects_test':
        return 0.08; // 8%
      case 'js_arrays_test':
        return 0.08; // 8%
      case 'js_destructuring_test':
        return 0.08; // 8%
      case 'objects_practice_easy':
        return 0.10; // 10%
      case 'arrays_practice_medium':
        return 0.12; // 12%
      case 'todo_app_project':
        return 0.20; // 20%
      default:
        return 0.05; // 5% для других тестов
    }
  }
  
  // Получить общую статистику
  static Map<String, dynamic> getStats() {
    final completedTests = getCompletedTests();
    final completedLessons = getCompletedLessons();
    final allTests = JSTestData.getAllTests();
    final totalTests = allTests.length;
    final completedTestsCount = completedTests.length;
    
    return {
      'totalXP': getCurrentXP(),
      'progress': getCurrentProgress(),
      'completedTests': completedTestsCount,
      'completedLessons': completedLessons.length,
      'totalTests': totalTests,
      'completionPercentage': totalTests > 0 ? (completedTestsCount / totalTests * 100).round() : 0,
    };
  }
  
  // Сбросить прогресс (для тестирования)
  static void resetProgress() {
    _localStorage = {
      _progressKey: 0.35,
      _xpKey: 450,
      _completedTestsKey: <String>[],
      _completedLessonsKey: <String>[],
    };
  }
  
  // Получить следующий доступный тест
  static String? getNextAvailableTest() {
    final completedTests = getCompletedTests();
    final allTestIds = ['js_variables_test', 'js_operators_test', 'js_variables_code', 'js_operators_code'];
    
    for (String testId in allTestIds) {
      if (!completedTests.contains(testId)) {
        return testId;
      }
    }
    
    return null; // Все тесты завершены
  }
  
  // Проверить, разблокирован ли проект калькулятора
  static bool isCalculatorProjectUnlocked() {
    final requiredTests = ['js_variables_test', 'js_operators_test', 'js_variables_code', 'js_operators_code'];
    final completedTests = getCompletedTests();
    
    return requiredTests.every((testId) => completedTests.contains(testId));
  }
} 