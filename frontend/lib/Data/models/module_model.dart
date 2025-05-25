import 'package:flutter/material.dart';
import 'lesson_model.dart';

class Module {
  final String id;
  final String title;
  final String description;
  final List<Lesson> lessons;
  final bool isExpanded;

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
    this.isExpanded = false,
  });

  Module copyWith({
    String? id,
    String? title,
    String? description,
    List<Lesson>? lessons,
    bool? isExpanded,
  }) {
    return Module(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lessons: lessons ?? this.lessons,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  int get completedLessonsCount => lessons.where((lesson) => lesson.isCompleted).length;
  int get totalLessonsCount => lessons.length;
  double get completionPercentage => totalLessonsCount > 0 ? completedLessonsCount / totalLessonsCount : 0.0;
} 