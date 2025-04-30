import 'package:get/get.dart';

class AIController extends GetxController {
  // Синглтон
  static final AIController _instance = AIController._internal();
  
  factory AIController() {
    return _instance;
  }
  
  AIController._internal();
  
  // Методы для работы с AI
  
  // Метод для проверки ответа на тестовое задание
  bool checkTestAnswer(Map<String, dynamic> task, int selectedAnswerIndex) {
    final question = task["questions"][0];
    return selectedAnswerIndex == question["correctAnswer"];
  }
  
  // Метод для оценки ответа на задание с анализом кода
  Map<String, dynamic> evaluateCodeAnalysisAnswer(Map<String, dynamic> task, String userAnswer) {
    // В реальном приложении здесь был бы запрос к AI API
    // Для демонстрации используем простую логику
    
    final String correctAnswer = task["correctAnswer"];
    final List<String> keyPhrases = _extractKeyPhrases(correctAnswer);
    
    int matchedPhrases = 0;
    for (String phrase in keyPhrases) {
      if (userAnswer.toLowerCase().contains(phrase.toLowerCase())) {
        matchedPhrases++;
      }
    }
    
    double score = matchedPhrases / keyPhrases.length;
    
    // Генерируем обратную связь
    String feedback = _generateFeedback(score, keyPhrases, userAnswer);
    
    return {
      "score": score,
      "feedback": feedback,
      "xpMultiplier": score, // Множитель XP в зависимости от качества ответа
    };
  }
  
  // Метод для оценки решения алгоритмической задачи
  Map<String, dynamic> evaluateAlgorithmSolution(Map<String, dynamic> task, String userSolution) {
    // В реальном приложении здесь был бы запрос к AI API
    // Для демонстрации используем простую логику
    
    final String sampleSolution = task["sampleSolution"];
    
    // Проверяем наличие ключевых элементов в решении
    bool hasCorrectApproach = _checkSolutionApproach(userSolution, task);
    bool isOptimal = _checkSolutionOptimality(userSolution);
    bool hasCorrectOutput = _checkSolutionOutput(userSolution, task);
    
    double score = 0;
    if (hasCorrectApproach) score += 0.5;
    if (isOptimal) score += 0.3;
    if (hasCorrectOutput) score += 0.2;
    
    // Генерируем обратную связь
    String feedback = _generateAlgorithmFeedback(score, hasCorrectApproach, isOptimal, hasCorrectOutput);
    
    return {
      "score": score,
      "feedback": feedback,
      "xpMultiplier": score, // Множитель XP в зависимости от качества решения
    };
  }
  
  // Метод для генерации вопросов для интервью
  List<String> generateInterviewQuestions(String track, String level) {
    // В реальном приложении здесь был бы запрос к AI API
    // Для демонстрации возвращаем предопределенные вопросы
    
    if (track.contains("Frontend") && level == "Junior") {
      return [
        "Расскажите о себе и своем опыте в программировании.",
        "Какие проекты вы реализовали с использованием React?",
        "Объясните разницу между props и state в React.",
        "Что такое виртуальный DOM и как он работает?",
        "Расскажите о жизненном цикле компонента в React.",
        "Что такое хуки в React и какие вы использовали?",
        "Как бы вы оптимизировали производительность React-приложения?",
        "Расскажите о вашем опыте работы с Redux или другими менеджерами состояний.",
        "Как вы тестируете React-компоненты?",
        "Какие инструменты разработчика вы используете при работе с React?",
      ];
    } else if (track.contains("Backend") && track.contains("Django") && level == "Junior") {
      return [
        "Расскажите о себе и своем опыте в программировании.",
        "Какие проекты вы реализовали с использованием Django?",
        "Объясните архитектуру MTV в Django.",
        "Что такое ORM и как он работает в Django?",
        "Расскажите о миграциях в Django.",
        "Как работает система аутентификации в Django?",
        "Что такое middleware в Django и для чего он используется?",
        "Как вы оптимизируете запросы к базе данных в Django?",
        "Расскажите о вашем опыте работы с Django REST Framework.",
        "Как вы тестируете Django-приложения?",
      ];
    } else {
      return [
        "Расскажите о себе и своем опыте в программировании.",
        "Какие проекты вы реализовали?",
        "Расскажите о вашем опыте работы с базами данных.",
        "Как вы подходите к решению сложных задач?",
        "Расскажите о вашем опыте работы в команде.",
        "Какие инструменты разработчика вы используете?",
        "Как вы поддерживаете свои знания в актуальном состоянии?",
        "Расскажите о вашем опыте с системами контроля версий.",
        "Как вы тестируете свой код?",
        "Какие технологии вы хотели бы изучить в будущем?",
      ];
    }
  }
  
  // Метод для оценки ответа на вопрос интервью
  Map<String, dynamic> evaluateInterviewAnswer(String question, String answer) {
    // В реальном приложении здесь был бы запрос к AI API
    // Для демонстрации используем простую логику
    
    // Проверяем длину ответа
    if (answer.length < 50) {
      return {
        "score": 0.3,
        "feedback": "Ваш ответ слишком короткий. Постарайтесь дать более развернутый ответ с примерами.",
      };
    } else if (answer.length < 100) {
      return {
        "score": 0.6,
        "feedback": "Хороший ответ, но можно добавить больше деталей и примеров из вашего опыта.",
      };
    } else {
      return {
        "score": 0.9,
        "feedback": "Отличный, развернутый ответ! Вы хорошо объяснили концепцию и привели примеры.",
      };
    }
  }
  
  // Вспомогательные методы
  
  List<String> _extractKeyPhrases(String text) {
    // В реальном приложении здесь был бы более сложный алгоритм
    // Для демонстрации просто разбиваем текст на предложения
    return text.split(". ");
  }
  
  String _generateFeedback(double score, List<String> keyPhrases, String userAnswer) {
    if (score > 0.8) {
      return "Отличный ответ! Вы правильно определили основные моменты.";
    } else if (score > 0.5) {
      return "Хороший ответ, но вы упустили некоторые важные моменты. Обратите внимание на: " + 
             keyPhrases.where((phrase) => !userAnswer.toLowerCase().contains(phrase.toLowerCase())).take(2).join(", ");
    } else {
      return "Ваш ответ нуждается в доработке. Важные моменты, которые стоит учесть: " + 
             keyPhrases.where((phrase) => !userAnswer.toLowerCase().contains(phrase.toLowerCase())).take(3).join(", ");
    }
  }
  
  bool _checkSolutionApproach(String solution, Map<String, dynamic> task) {
    // В реальном приложении здесь был бы более сложный алгоритм
    // Для демонстрации используем простую проверку
    return solution.length > 50;
  }
  
  bool _checkSolutionOptimality(String solution) {
    // В реальном приложении здесь был бы более сложный алгоритм
    // Для демонстрации используем простую проверку
    return !solution.contains("for (let i = 0; i < array.length; i++)") || solution.contains("O(n)");
  }
  
  bool _checkSolutionOutput(String solution, Map<String, dynamic> task) {
    // В реальном приложении здесь был бы более сложный алгоритм
    // Для демонстрации используем простую проверку
    return solution.contains("return") || solution.contains("console.log");
  }
  
  String _generateAlgorithmFeedback(double score, bool hasCorrectApproach, bool isOptimal, bool hasCorrectOutput) {
    List<String> feedbackPoints = [];
    
    if (hasCorrectApproach) {
      feedbackPoints.add("Вы выбрали правильный подход к решению задачи.");
    } else {
      feedbackPoints.add("Ваш подход к решению задачи нуждается в доработке.");
    }
    
    if (isOptimal) {
      feedbackPoints.add("Ваше решение оптимально по времени и памяти.");
    } else {
      feedbackPoints.add("Ваше решение можно оптимизировать для лучшей производительности.");
    }
    
    if (hasCorrectOutput) {
      feedbackPoints.add("Ваше решение корректно возвращает результат.");
    } else {
      feedbackPoints.add("Убедитесь, что ваше решение возвращает правильный результат.");
    }
    
    return feedbackPoints.join(" ");
  }
} 