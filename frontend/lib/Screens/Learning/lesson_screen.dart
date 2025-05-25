import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Data/models/lesson_model.dart';

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF5B5FEF)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          lesson.title,
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              lesson.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              color: lesson.isCompleted ? Color(0xFF5B5FEF) : Colors.grey,
            ),
            onPressed: () {
              // TODO: Implement lesson completion toggle
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLessonHeader(),
              SizedBox(height: 20),
              _buildLessonContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF5B5FEF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            _getLessonTypeIcon(),
            color: Color(0xFF5B5FEF),
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getLessonTypeText(),
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF5B5FEF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${lesson.duration} минут',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF2D3142).withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonContent() {
    return Text(
      lesson.content,
      style: GoogleFonts.montserrat(
        color: Color(0xFF2D3142),
        fontSize: 16,
        height: 1.6,
      ),
    );
  }

  IconData _getLessonTypeIcon() {
    switch (lesson.type) {
      case LessonType.theory:
        return Icons.menu_book;
      case LessonType.task:
        return Icons.assignment;
      case LessonType.project:
        return Icons.code;
      case LessonType.quiz:
        return Icons.quiz;
    }
  }

  String _getLessonTypeText() {
    switch (lesson.type) {
      case LessonType.theory:
        return 'Теоретический урок';
      case LessonType.task:
        return 'Практическое задание';
      case LessonType.project:
        return 'Проект';
      case LessonType.quiz:
        return 'Тест';
    }
  }
} 