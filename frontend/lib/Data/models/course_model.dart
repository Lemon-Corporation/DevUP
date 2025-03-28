import 'package:flutter/material.dart';

class Course {
  final String id;
  final String title;
  final String emoji;
  final String description;
  final String level; // Junior, Middle, Senior
  final String technology; // React, Django, Spring
  final String field; // Frontend, Backend
  final double rating;
  final int reviewsCount;
  final List<Module> modules;
  final Instructor instructor;
  final int totalLessonsCount;
  final int totalTasksCount;
  final int estimatedHours;
  
  Course({
    required this.id,
    required this.title,
    required this.emoji,
    required this.description,
    required this.level,
    required this.technology,
    required this.field,
    required this.rating,
    required this.reviewsCount,
    required this.modules,
    required this.instructor,
    required this.totalLessonsCount,
    required this.totalTasksCount,
    required this.estimatedHours,
  });
  
  // Геттеры
  int get moduleCount => modules.length;
  
  // Фабричные методы для создания курсов
  factory Course.createFrontendReact({required String level}) {
    return Course(
      id: "${level.toLowerCase()}-frontend",
      title: "$level Frontend (React)",
      emoji: "🖥️",
      description: "Полный курс по фронтенд-разработке с использованием React",
      level: level,
      technology: "React",
      field: "Frontend",
      rating: 4.8,
      reviewsCount: 256,
      modules: _createFrontendModules(),
      instructor: Instructor(
        id: "instr1",
        name: "Александр Ганяк",
        title: "Senior Frontend Developer",
        avatarInitials: "АГ",
      ),
      totalLessonsCount: 24,
      totalTasksCount: 36,
      estimatedHours: 40,
    );
  }
  
  factory Course.createBackendDjango({required String level}) {
    return Course(
      id: "${level.toLowerCase()}-backend-django",
      title: "$level Backend (Django)",
      emoji: "🗄️",
      description: "Полный курс по бэкенд-разработке с использованием Django",
      level: level,
      technology: "Django",
      field: "Backend",
      rating: 4.7,
      reviewsCount: 189,
      modules: _createBackendModules("Django"),
      instructor: Instructor(
        id: "instr2",
        name: "Мария Петрова",
        title: "Senior Python Developer",
        avatarInitials: "МП",
      ),
      totalLessonsCount: 22,
      totalTasksCount: 32,
      estimatedHours: 38,
    );
  }
  
  factory Course.createBackendSpring({required String level}) {
    return Course(
      id: "${level.toLowerCase()}-backend-spring",
      title: "$level Backend (Spring)",
      emoji: "🗄️",
      description: "Полный курс по бэкенд-разработке с использованием Spring",
      level: level,
      technology: "Spring",
      field: "Backend",
      rating: 4.6,
      reviewsCount: 142,
      modules: _createBackendModules("Spring"),
      instructor: Instructor(
        id: "instr3",
        name: "Иван Семенов",
        title: "Senior Java Developer",
        avatarInitials: "ИС",
      ),
      totalLessonsCount: 20,
      totalTasksCount: 30,
      estimatedHours: 36,
    );
  }
  
  // Вспомогательные методы для создания модулей
  static List<Module> _createFrontendModules() {
    return [
      Module(
        id: "module-1",
        title: "Введение и основы",
        lessons: [
          Lesson(
            id: "lesson-1-1",
            title: "Введение в JavaScript",
            type: LessonType.theory,
            duration: 15,
          ),
          Lesson(
            id: "lesson-1-2",
            title: "Переменные и типы данных",
            type: LessonType.theory,
            duration: 20,
          ),
          Lesson(
            id: "lesson-1-3",
            title: "Операторы и выражения",
            type: LessonType.theory,
            duration: 25,
          ),
          Lesson(
            id: "lesson-1-4",
            title: "Переменные и типы данных",
            type: LessonType.task,
            taskId: "test1",
          ),
          Lesson(
            id: "lesson-1-5",
            title: "Работа с числами",
            type: LessonType.task,
            taskId: "algo1",
          ),
          Lesson(
            id: "lesson-1-6",
            title: "Условные операторы",
            type: LessonType.task,
            taskId: "code1",
          ),
          Lesson(
            id: "lesson-1-7",
            title: "Калькулятор на JavaScript",
            type: LessonType.project,
            description: "Создайте простой калькулятор с использованием HTML, CSS и JavaScript",
            xpReward: 50,
          ),
        ],
      ),
      Module(
        id: "module-2",
        title: "Функции и область видимости",
        lessons: [
          Lesson(
            id: "lesson-2-1",
            title: "Функции в JavaScript",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-2-2",
            title: "Область видимости",
            type: LessonType.theory,
            duration: 25,
          ),
          Lesson(
            id: "lesson-2-3",
            title: "Замыкания",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-2-4",
            title: "Работа с функциями",
            type: LessonType.task,
            taskId: "test3",
          ),
          Lesson(
            id: "lesson-2-5",
            title: "Замыкания в практике",
            type: LessonType.task,
            taskId: "code2",
          ),
          Lesson(
            id: "lesson-2-6",
            title: "Таймер с использованием замыканий",
            type: LessonType.project,
            description: "Создайте таймер обратного отсчета с использованием замыканий",
            xpReward: 60,
          ),
        ],
      ),
      Module(
        id: "module-3",
        title: "Объекты и массивы",
        lessons: [
          Lesson(
            id: "lesson-3-1",
            title: "Объекты в JavaScript",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-3-2",
            title: "Массивы и методы массивов",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-3-3",
            title: "Деструктуризация и spread оператор",
            type: LessonType.theory,
            duration: 25,
          ),
          Lesson(
            id: "lesson-3-4",
            title: "Работа с объектами",
            type: LessonType.task,
            taskId: "test4",
          ),
          Lesson(
            id: "lesson-3-5",
            title: "Манипуляции с массивами",
            type: LessonType.task,
            taskId: "algo2",
          ),
          Lesson(
            id: "lesson-3-6",
            title: "Список задач (Todo App)",
            type: LessonType.project,
            description: "Создайте приложение списка задач с использованием объектов и массивов",
            xpReward: 70,
          ),
        ],
      ),
      Module(
        id: "module-4",
        title: "Асинхронный JavaScript",
        lessons: [
          Lesson(
            id: "lesson-4-1",
            title: "Колбэки и асинхронность",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-4-2",
            title: "Промисы (Promises)",
            type: LessonType.theory,
            duration: 40,
          ),
          Lesson(
            id: "lesson-4-3",
            title: "Async/Await",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-4-4",
            title: "Работа с промисами",
            type: LessonType.task,
            taskId: "code3",
          ),
          Lesson(
            id: "lesson-4-5",
            title: "Асинхронные операции",
            type: LessonType.task,
            taskId: "algo3",
          ),
          Lesson(
            id: "lesson-4-6",
            title: "Погодное приложение с API",
            type: LessonType.project,
            description: "Создайте приложение погоды, использующее внешний API с асинхронными запросами",
            xpReward: 80,
          ),
        ],
      ),
      Module(
        id: "module-5",
        title: "Основы React",
        lessons: [
          Lesson(
            id: "lesson-5-1",
            title: "Введение в React",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-5-2",
            title: "Компоненты и пропсы",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-5-3",
            title: "Состояние и жизненный цикл",
            type: LessonType.theory,
            duration: 40,
          ),
          Lesson(
            id: "lesson-5-4",
            title: "Основы React",
            type: LessonType.task,
            taskId: "test5",
          ),
          Lesson(
            id: "lesson-5-5",
            title: "Компоненты React",
            type: LessonType.task,
            taskId: "code4",
          ),
          Lesson(
            id: "lesson-5-6",
            title: "Счетчик на React",
            type: LessonType.project,
            description: "Создайте простое приложение счетчика с использованием React",
            xpReward: 70,
          ),
        ],
      ),
      Module(
        id: "module-6",
        title: "Итоговый проект",
        lessons: [
          Lesson(
            id: "lesson-6-1",
            title: "Подготовка к проекту",
            type: LessonType.theory,
            duration: 25,
          ),
          Lesson(
            id: "lesson-6-2",
            title: "Планирование архитектуры",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-6-3",
            title: "Интернет-магазин на React",
            type: LessonType.project,
            description: "Создайте полноценный интернет-магазин с использованием React и всех изученных концепций",
            xpReward: 200,
          ),
        ],
      ),
    ];
  }
  
  static List<Module> _createBackendModules(String technology) {
    final bool isDjango = technology == "Django";
    final String lang = isDjango ? "Python" : "Java";
    
    return [
      Module(
        id: "module-1",
        title: "Введение и основы",
        lessons: [
          Lesson(
            id: "lesson-1-1",
            title: "Введение в $lang",
            type: LessonType.theory,
            duration: 20,
          ),
          Lesson(
            id: "lesson-1-2",
            title: "Типы данных",
            type: LessonType.theory,
            duration: 25,
          ),
          Lesson(
            id: "lesson-1-3",
            title: "Структуры управления",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-1-4",
            title: "Основы $lang",
            type: LessonType.task,
            taskId: isDjango ? "python1" : "java1",
          ),
          Lesson(
            id: "lesson-1-5",
            title: "Задачи на алгоритмы",
            type: LessonType.task,
            taskId: isDjango ? "pyalgo1" : "jalgo1",
          ),
          Lesson(
            id: "lesson-1-6",
            title: "Калькулятор на $lang",
            type: LessonType.project,
            description: "Создайте консольный калькулятор на языке $lang",
            xpReward: 50,
          ),
        ],
      ),
      Module(
        id: "module-2",
        title: "ООП и основы архитектуры",
        lessons: [
          Lesson(
            id: "lesson-2-1",
            title: "Классы и объекты",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-2-2",
            title: "Наследование и полиморфизм",
            type: LessonType.theory,
            duration: 40,
          ),
          Lesson(
            id: "lesson-2-3",
            title: "Принципы SOLID",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-2-4",
            title: "ООП на практике",
            type: LessonType.task,
            taskId: isDjango ? "python2" : "java2",
          ),
          Lesson(
            id: "lesson-2-5",
            title: "Система учета студентов",
            type: LessonType.project,
            description: "Создайте консольное приложение для учета студентов с использованием ООП",
            xpReward: 70,
          ),
        ],
      ),
      Module(
        id: "module-3",
        title: "Работа с базами данных",
        lessons: [
          Lesson(
            id: "lesson-3-1",
            title: "Основы SQL",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-3-2",
            title: isDjango ? "ORM в Django" : "JPA и Hibernate",
            type: LessonType.theory,
            duration: 40,
          ),
          Lesson(
            id: "lesson-3-3",
            title: "Проектирование баз данных",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-3-4",
            title: "SQL запросы",
            type: LessonType.task,
            taskId: "sql1",
          ),
          Lesson(
            id: "lesson-3-5",
            title: isDjango ? "Django ORM" : "JPA и Hibernate",
            type: LessonType.task,
            taskId: isDjango ? "django1" : "jpa1",
          ),
          Lesson(
            id: "lesson-3-6",
            title: "Система управления задачами с БД",
            type: LessonType.project,
            description: "Создайте приложение для управления задачами с использованием базы данных",
            xpReward: 80,
          ),
        ],
      ),
      Module(
        id: "module-4",
        title: isDjango ? "Django Web Framework" : "Spring Boot",
        lessons: [
          Lesson(
            id: "lesson-4-1",
            title: isDjango ? "Введение в Django" : "Введение в Spring Boot",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-4-2",
            title: "MVC/MTV архитектура",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-4-3",
            title: isDjango ? "Django Views и Templates" : "Spring MVC",
            type: LessonType.theory,
            duration: 40,
          ),
          Lesson(
            id: "lesson-4-4",
            title: isDjango ? "Настройка Django" : "Настройка Spring Boot",
            type: LessonType.task,
            taskId: isDjango ? "django2" : "spring1",
          ),
          Lesson(
            id: "lesson-4-5",
            title: "Создание первого веб-приложения",
            type: LessonType.project,
            description: "Создайте простое веб-приложение с использованием ${isDjango ? 'Django' : 'Spring Boot'}",
            xpReward: 80,
          ),
        ],
      ),
      Module(
        id: "module-5",
        title: "REST API и аутентификация",
        lessons: [
          Lesson(
            id: "lesson-5-1",
            title: "Основы REST API",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-5-2",
            title: isDjango ? "Django REST Framework" : "Spring REST",
            type: LessonType.theory,
            duration: 40,
          ),
          Lesson(
            id: "lesson-5-3",
            title: "Аутентификация и авторизация",
            type: LessonType.theory,
            duration: 35,
          ),
          Lesson(
            id: "lesson-5-4",
            title: "Создание API",
            type: LessonType.task,
            taskId: isDjango ? "django3" : "spring2",
          ),
          Lesson(
            id: "lesson-5-5",
            title: "Система аутентификации",
            type: LessonType.task,
            taskId: isDjango ? "django4" : "spring3",
          ),
          Lesson(
            id: "lesson-5-6",
            title: "REST API для блога",
            type: LessonType.project,
            description: "Создайте REST API для блога с аутентификацией и авторизацией",
            xpReward: 100,
          ),
        ],
      ),
      Module(
        id: "module-6",
        title: "Итоговый проект",
        lessons: [
          Lesson(
            id: "lesson-6-1",
            title: "Планирование архитектуры",
            type: LessonType.theory,
            duration: 25,
          ),
          Lesson(
            id: "lesson-6-2",
            title: "Лучшие практики и паттерны",
            type: LessonType.theory,
            duration: 30,
          ),
          Lesson(
            id: "lesson-6-3",
            title: "Социальная сеть",
            type: LessonType.project,
            description: "Разработайте бэкенд для социальной сети с использованием ${isDjango ? 'Django' : 'Spring Boot'}",
            xpReward: 200,
          ),
        ],
      ),
    ];
  }
  
  // Статический метод для получения всех курсов
  static List<Course> getAllCourses() {
    return [
      Course.createFrontendReact(level: "beginner"),
      Course.createFrontendReact(level: "intermediate"),
      Course.createFrontendReact(level: "advanced"),
      Course.createBackendDjango(level: "beginner"),
      Course.createBackendDjango(level: "intermediate"),
      Course.createBackendDjango(level: "advanced"),
      Course.createBackendSpring(level: "beginner"),
      Course.createBackendSpring(level: "intermediate"),
      Course.createBackendSpring(level: "advanced"),
    ];
  }
  
  // Получение курса по ID
  static Course? getCourseById(String id) {
    try {
      return getAllCourses().firstWhere((course) => course.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Получение курсов по уровню
  static List<Course> getCoursesByLevel(String level) {
    return getAllCourses().where((course) => course.level == level).toList();
  }
}

class Module {
  final String id;
  final String title;
  final List<Lesson> lessons;
  
  Module({
    required this.id,
    required this.title,
    required this.lessons,
  });
  
  int get theoryLessonsCount => lessons.where((lesson) => lesson.type == LessonType.theory).length;
  int get taskLessonsCount => lessons.where((lesson) => lesson.type == LessonType.task).length;
  int get projectLessonsCount => lessons.where((lesson) => lesson.type == LessonType.project).length;
  int get totalLessonsCount => lessons.length;
}

enum LessonType {
  theory,   // Теоретический материал
  task,     // Практическое задание
  project,  // Проектное задание
}

class Lesson {
  final String id;
  final String title;
  final LessonType type;
  final int? duration;  // Для теоретических уроков, в минутах
  final String? taskId; // Для заданий, ссылка на задание
  final String? description; // Для проектов
  final int? xpReward;  // Для проектов, награда опытом
  
  Lesson({
    required this.id,
    required this.title,
    required this.type,
    this.duration,
    this.taskId,
    this.description,
    this.xpReward,
  });
}

class Instructor {
  final String id;
  final String name;
  final String title;
  final String avatarInitials;
  final String? avatarUrl;
  final double rating;
  final int studentsCount;
  
  Instructor({
    required this.id,
    required this.name,
    required this.title,
    required this.avatarInitials,
    this.avatarUrl,
    this.rating = 4.5,
    this.studentsCount = 0,
  });
  
  // Getters to ensure compatibility
  String get avatarText => avatarInitials;
  String get position => title;
} 