import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Data/data_model.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:devup/widgets/Gamification/daily_challenge.dart';

class DailyChallengesScreen extends StatelessWidget {
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
                        "Ежедневные челленджи",
                        style: GoogleFonts.firaCode(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildDailyStreak(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Сегодняшние челленджи",
                    style: GoogleFonts.firaCode(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      ...AppData.dailyChallenges.map((challenge) => 
                        DailyChallenge(
                          title: challenge["title"],
                          reward: challenge["reward"],
                          progress: challenge["progress"],
                          total: challenge["total"],
                          onTap: () {
                            // Действие при нажатии на челлендж
                          },
                        )
                      ).toList(),
                      SizedBox(height: 20),
                      _buildCompletedChallengesSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyStreak() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DailyStreak(
        streak: 7,
        weekProgress: [true, true, true, true, true, true, true],
      ),
    );
  }

  Widget _buildCompletedChallengesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Выполненные челленджи",
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
              _buildCompletedChallengeItem(
                title: "Решите 5 задач",
                date: "Вчера",
                reward: "+100 XP",
              ),
              Divider(height: 30, color: AppColors.textLight.withOpacity(0.2)),
              _buildCompletedChallengeItem(
                title: "Пройдите тест по JavaScript",
                date: "2 дня назад",
                reward: "+150 XP",
              ),
              Divider(height: 30, color: AppColors.textLight.withOpacity(0.2)),
              _buildCompletedChallengeItem(
                title: "Изучите новую тему",
                date: "3 дня назад",
                reward: "+200 XP",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedChallengeItem({
    required String title,
    required String date,
    required String reward,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: AppColors.success,
            size: 24,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 5),
              Text(
                date,
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.xp.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            reward,
            style: GoogleFonts.firaCode(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.xp,
            ),
          ),
        ),
      ],
    );
  }
} 