import 'package:devup/Data/js_test_data.dart';

// Класс для управления прогрессом пользователя
class ProgressManager {
  static const String _progressKey = 'user_progress';
  static const String _xpKey = 'user_xp';
  static const String _completedTestsKey = 'completed_tests';
  
  // Симуляция локального хранилища (в реальном приложении используйте SharedPreferences)
  static Map<String, dynamic> _localStorage = {
    _progressKey: 0.35, // 35% начальный прогресс
    _xpKey: 450, // начальный XP
    _completedTestsKey: <String>[],
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
  
  // Проверить, завершен ли тест
  static bool isTestCompleted(String testId) {
    return getCompletedTests().contains(testId);
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
      default:
        return 0.05; // 5% для других тестов
    }
  }
  
  // Получить общую статистику
  static Map<String, dynamic> getStats() {
    final completedTests = getCompletedTests();
    final allTests = JSTestData.getAllTests();
    final totalTests = allTests.length;
    final completedCount = completedTests.length;
    
    return {
      'totalXP': getCurrentXP(),
      'progress': getCurrentProgress(),
      'completedTests': completedCount,
      'totalTests': totalTests,
      'completionPercentage': totalTests > 0 ? (completedCount / totalTests * 100).round() : 0,
    };
  }
  
  // Сбросить прогресс (для тестирования)
  static void resetProgress() {
    _localStorage = {
      _progressKey: 0.35,
      _xpKey: 450,
      _completedTestsKey: <String>[],
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