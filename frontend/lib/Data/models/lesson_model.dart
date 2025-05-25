import 'package:flutter/material.dart';


enum LessonType {
  theory,
  task,
  project,
  quiz,
}

class Lesson {
  final String id;
  final String title;
  final String content;     
  final int duration;      
  final bool isCompleted;
  final LessonType type;
  final String? taskId;
  final String? description;
  final int? xpReward;

  Lesson({
    required this.id,
    required this.title,
    this.content = "",
    this.duration = 0,       
    this.isCompleted = false,
    required this.type,
    this.taskId,
    this.description,
    this.xpReward,
  });

  Lesson copyWith({
    String? id,
    String? title,
    String? content,
    int? duration,
    bool? isCompleted,
    LessonType? type,
    String? taskId,
    String? description,
    int? xpReward,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
      type: type ?? this.type,
      taskId: taskId ?? this.taskId,
      description: description ?? this.description,
      xpReward: xpReward ?? this.xpReward,
    );
  }
}
