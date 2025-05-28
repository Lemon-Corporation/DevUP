import 'package:devup/Data/data_model.dart';
import 'package:devup/Screens/Learning/daily_challenges_screen.dart';
import 'package:devup/Screens/Learning/ai_interview_screen.dart';
import 'package:devup/Screens/Learning/simple_interview_screen.dart';
import 'package:devup/Screens/Learning/track_selection_screen.dart';
import 'package:devup/Screens/Learning/user_profile_screen.dart';
import 'package:devup/Screens/Learning/interview_selection_screen.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: Colors.white,
            position: "topLeft",
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 30),
                  _buildUserStats(),
                  SizedBox(height: 30),
                  _buildMainActions(),
                  SizedBox(height: 30),
                  _buildDailyChallenges(),
                  SizedBox(height: 30),
                  _buildProgress(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Привет,",
              style: TextStyle(
                fontFamily: 'Unbounded',
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Text(
              "User 👋🏻",
              style: TextStyle(
                fontFamily: 'Unbounded',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => UserProfileScreen());
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF5B5FEF), Color(0xFF00C9B1)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF5B5FEF).withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "UR",
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserStats() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.star,
            value: "1250",
            label: "XP",
            color: Color(0xFF5B5FEF),
            emoji: "✨",
          ),
          _buildDivider(),
          _buildStatItem(
            icon: Icons.bolt,
            value: "25",
            label: "Энергия",
            color: Color(0xFFFFC107),
            emoji: "⚡️",
          ),
          _buildDivider(),
          _buildStatItem(
            icon: Icons.emoji_events,
            value: "7",
            label: "Уровень",
            color: Color(0xFF00C9B1),
            emoji: "🏆",
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required String emoji,
  }) {
    return Column(
      children: [
        Text(
          emoji,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.black.withOpacity(0.1),
    );
  }

  // Основные действия (Практика, Собеседование)
  Widget _buildMainActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Что будем делать сегодня? 🚀",
          style: TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: "Практика",
                subtitle: "Решайте задачи",
                emoji: "👨‍💻",
                color: Color(0xFF5B5FED),
                onTap: () {
                  Get.to(() => TrackSelectionScreen());
                },
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: _buildActionCard(
                title: "Собеседование",
                subtitle: "AI-интервьюер",
                emoji: "🤖",
                color: Color(0xFF00C9B1),
                onTap: () {
                  print("🔧 DEBUG: Tapping on AI Interview card");
                  try {
                    // Проверяем доступность функций перед навигацией
                    Get.to(() => AIInterviewScreen());
                    print("🔧 DEBUG: Navigation to AIInterviewScreen successful");
                  } catch (e) {
                    print("🔧 DEBUG: Error navigating to AIInterviewScreen: $e");
                    // Показываем пользователю сообщение об ошибке
                    Get.snackbar(
                      "Внимание",
                      "Переходим к упрощенной версии собеседования",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.warning,
                      colorText: Colors.white,
                      duration: Duration(seconds: 2),
                    );
                    
                    // Используем простую версию как fallback
                    Future.delayed(Duration(milliseconds: 500), () {
                      try {
                        Get.to(() => SimpleInterviewScreen());
                      } catch (e2) {
                        print("🔧 DEBUG: Error with SimpleInterviewScreen: $e2");
                        // Последний fallback - список собеседований
                        Get.to(() => InterviewSelectionScreen());
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Container(), // Empty container for symmetry
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required String emoji,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: 41,
              ),
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Unbounded',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: GoogleFonts.firaCode(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyChallenges() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ежедневные челленджи 🔥",
              style: TextStyle(
                fontFamily: 'Unbounded',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => DailyChallengesScreen());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF5B5FEF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Все",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5B5FEF),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFEDEDED),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "🔥",
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Серия: 7 дней",
                          style: TextStyle(
                            fontFamily: 'Unbounded',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Выполняйте челленджи каждый день",
                          style: GoogleFonts.firaCode(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ...AppData.dailyChallenges
                  .take(2)
                  .map((challenge) => _buildChallengeItem(challenge))
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeItem(Map<String, dynamic> challenge) {
    final double progress = challenge["progress"] / challenge["total"];
    final String emoji = challenge["title"].contains("тест") ? "📝" : "🧩";

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                emoji,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          challenge["title"],
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${challenge["progress"]}/${challenge["total"]}",
                          style: GoogleFonts.firaCode(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: progress,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFC107),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Награда: ${challenge["reward"]}",
                      style: GoogleFonts.firaCode(
                        fontSize: 12,
                        color: Color(0xFF5B5FEF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ваш прогресс 📊",
          style: TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              ...AppData.progressIndicatorList
                  .take(3)
                  .map((progress) => _buildProgressItem(progress))
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressItem(Map<String, dynamic> progress) {
    final double progressValue = double.parse(progress["progress"]) / 100;
    final int progressBarType = int.parse(progress["progressBar"]);

    Color progressColor;
    String emoji;
    switch (progressBarType) {
      case 1:
        progressColor = AppColors.error;
        emoji = "🔴";
        break;
      case 2:
        progressColor = AppColors.warning;
        emoji = "🟠";
        break;
      case 3:
        progressColor = AppColors.success;
        emoji = "🟢";
        break;
      default:
        progressColor = AppColors.primary;
        emoji = "🔵";
    }

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Text(
                      emoji,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        progress["cardTitle"],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Unbounded',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: progressColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  progress["rating"],
                  style: GoogleFonts.firaCode(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.05),
                          width: 1,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progressValue,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: progressColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Text(
                "${progress["progress"]}%",
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                ),
              ),
            ],
          ),
          if (progressBarType != 3 && double.parse(progress["progress"]) < 100)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.textSecondary,
                    size: 14,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "Продолжайте практиковаться для улучшения",
                      style: GoogleFonts.firaCode(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          if (progressBarType == 3 || double.parse(progress["progress"]) >= 100)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.success,
                    size: 14,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      "Отличный прогресс! Продолжайте в том же духе",
                      style: GoogleFonts.firaCode(
                        fontSize: 12,
                        color: AppColors.success,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          if (progressBarType != 3 && progressBarType != 1) Divider(height: 30),
        ],
      ),
    );
  }
}
