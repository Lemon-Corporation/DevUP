import 'package:devup/Data/data_model.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfileScreen extends StatelessWidget {
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
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
                        Text(
                          "Профиль",
                          style: GoogleFonts.firaCode(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildUserHeader(),
                  SizedBox(height: 20),
                  _buildStatsSection(),
                  SizedBox(height: 20),
                  _buildProgressSection(),
                  SizedBox(height: 20),
                  _buildAchievementsSection(),
                  SizedBox(height: 20),
                  _buildDailyChallengesSection(),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "АГ",
                style: GoogleFonts.firaCode(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Александр Ганяк",
                  style: GoogleFonts.firaCode(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Junior Frontend Developer",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _buildLevelIndicator(3),
                    SizedBox(width: 10),
                    Text(
                      "Уровень 3",
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelIndicator(int level) {
    return Container(
      width: 100,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Container(
            width: level * 20.0,
            height: 6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Статистика",
            style: GoogleFonts.firaCode(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  icon: Icons.star,
                  value: "1250",
                  label: "XP",
                  color: AppColors.xp,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.bolt,
                  value: "25",
                  label: "Энергия",
                  color: AppColors.energy,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: _buildStatCard(
                  icon: Icons.check_circle,
                  value: "42",
                  label: "Задания",
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
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
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.firaCode(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.firaCode(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Прогресс по направлениям",
            style: GoogleFonts.firaCode(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15),
          ...AppData.progressIndicatorList
              .map((progress) => _buildProgressItem(progress))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildProgressItem(Map<String, dynamic> progress) {
    final double progressValue = double.parse(progress["progress"]) / 100;
    final int progressBarType = int.parse(progress["progressBar"]);

    Color progressColor;
    switch (progressBarType) {
      case 1:
        progressColor = AppColors.error;
        break;
      case 2:
        progressColor = AppColors.warning;
        break;
      case 3:
        progressColor = AppColors.success;
        break;
      default:
        progressColor = AppColors.primary;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progress["cardTitle"],
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
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
          SizedBox(height: 15),
          Stack(
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
              Container(
                width: MediaQuery.of(Get.context!).size.width *
                    0.8 *
                    progressValue,
                height: 8,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
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
    );
  }

  Widget _buildAchievementsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Достижения",
            style: GoogleFonts.firaCode(
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
              borderRadius: BorderRadius.circular(15),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAchievementItem(
                      emoji: "🔥",
                      title: "7 дней подряд",
                      isUnlocked: true,
                    ),
                    _buildAchievementItem(
                      emoji: "🧠",
                      title: "10 задач",
                      isUnlocked: true,
                    ),
                    _buildAchievementItem(
                      emoji: "🏆",
                      title: "Первый тест",
                      isUnlocked: true,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAchievementItem(
                      emoji: "⚡",
                      title: "Быстрый ответ",
                      isUnlocked: true,
                    ),
                    _buildAchievementItem(
                      emoji: "🌟",
                      title: "1000 XP",
                      isUnlocked: true,
                    ),
                    _buildAchievementItem(
                      emoji: "🔒",
                      title: "???",
                      isUnlocked: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem({
    required String emoji,
    required String title,
    required bool isUnlocked,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isUnlocked
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: isUnlocked
                  ? AppColors.primary
                  : Colors.black.withOpacity(0.1),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.firaCode(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDailyChallengesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ежедневные челленджи",
                style: GoogleFonts.firaCode(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Все",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          ...AppData.dailyChallenges
              .take(3)
              .map((challenge) => _buildChallengeItem(challenge))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildChallengeItem(Map<String, dynamic> challenge) {
    final double progress = challenge["progress"] / challenge["total"];
    final bool isCompleted = challenge["progress"] == challenge["total"];

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isCompleted ? AppColors.success : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (isCompleted ? AppColors.success : AppColors.energy)
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getIconForChallenge(challenge["title"]),
                  color: isCompleted ? AppColors.success : AppColors.energy,
                  size: 30,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge["title"],
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.xp,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          challenge["reward"],
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: AppColors.success,
                    size: 20,
                  ),
                ),
            ],
          ),
          SizedBox(height: 15),
          Stack(
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
              Container(
                width: MediaQuery.of(Get.context!).size.width * 0.7 * progress,
                height: 8,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.success : AppColors.energy,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${challenge["progress"]}/${challenge["total"]}",
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                isCompleted ? "Выполнено" : "В процессе",
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color:
                      isCompleted ? AppColors.success : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconForChallenge(String title) {
    if (title.contains("тест")) {
      return Icons.assignment;
    } else if (title.contains("задач")) {
      return Icons.code;
    } else if (title.contains("собеседование")) {
      return Icons.person;
    } else {
      return Icons.star;
    }
  }
}
