import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:devup/Screens/Learning/interview_simulation_screen.dart';
import 'package:devup/Screens/Learning/ml_interview_screen.dart';

class InterviewSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: AppColors.background,
            position: "topLeft",
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        SizedBox(height: 30),
                        _buildInterviewTypes(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 15),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          SizedBox(width: 15),
          Text(
            "Собеседования",
            style: GoogleFonts.firaCode(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Выберите тип собеседования",
          style: TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Практикуйте ответы на популярные вопросы и развивайте навыки прохождения интервью",
          style: GoogleFonts.firaCode(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInterviewTypes() {
    return Column(
      children: [
        _buildInterviewCard(
          title: "Frontend React",
          description: "Собеседование по React и основам frontend разработки",
          emoji: "⚛️",
          color: AppColors.primary,
          difficulty: "Средний",
          duration: "30-40 мин",
          questions: 10,
          onTap: () {
            Get.to(() => InterviewSimulationScreen());
          },
        ),
        SizedBox(height: 15),
        _buildInterviewCard(
          title: "Machine Learning",
          description: "Вопросы по основам машинного обучения и нейронных сетей",
          emoji: "🧠",
          color: Color(0xFFFFA726),
          difficulty: "Продвинутый",
          duration: "25-30 мин",
          questions: 10,
          onTap: () {
            Get.to(() => MLInterviewScreen());
          },
        ),
        SizedBox(height: 15),
        _buildInterviewCard(
          title: "Java Backend",
          description: "Вопросы о Java, Spring и серверной разработке",
          emoji: "☕",
          color: Color(0xFF4CAF50),
          difficulty: "Сложный",
          duration: "35-45 мин",
          questions: 12,
          onTap: () {
            // Уведомление о том, что собеседование будет доступно скоро
            Get.snackbar(
              "Скоро",
              "Java Backend собеседование появится в ближайшем обновлении",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.primary,
              colorText: Colors.white,
            );
          },
        ),
        SizedBox(height: 15),
        _buildInterviewCard(
          title: "Python Data Science",
          description: "Задачи по анализу данных и алгоритмам на Python",
          emoji: "🐍",
          color: Color(0xFF2196F3),
          difficulty: "Средний",
          duration: "30-40 мин",
          questions: 10,
          onTap: () {
            // Уведомление о том, что собеседование будет доступно скоро
            Get.snackbar(
              "Скоро",
              "Python Data Science собеседование появится в ближайшем обновлении",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.primary,
              colorText: Colors.white,
            );
          },
        ),
      ],
    );
  }

  Widget _buildInterviewCard({
    required String title,
    required String description,
    required String emoji,
    required Color color,
    required String difficulty,
    required String duration,
    required int questions,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      emoji,
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    difficulty,
                    style: GoogleFonts.firaCode(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              description,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.timer,
                  text: duration,
                  color: color,
                ),
                SizedBox(width: 15),
                _buildInfoChip(
                  icon: Icons.question_answer,
                  text: "$questions вопросов",
                  color: color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.firaCode(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
} 