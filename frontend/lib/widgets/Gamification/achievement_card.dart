import 'package:flutter/material.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/Gamification/progress_bar.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final int progress;
  final int total;
  final String? iconPath;
  final String? reward;
  final bool isCompleted;
  final VoidCallback? onTap;

  const AchievementCard({
    Key? key,
    required this.title,
    required this.description,
    required this.progress,
    required this.total,
    this.iconPath,
    this.reward,
    this.isCompleted = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progressValue = progress / total;
    final Color progressColor = isCompleted 
        ? AppColors.success 
        : AppColors.xp;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: isCompleted 
              ? Border.all(color: AppColors.success, width: 2) 
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
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
                    color: (isCompleted ? AppColors.success : AppColors.xp).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: iconPath != null 
                        ? Image.asset(
                            iconPath!, 
                            width: 30, 
                            height: 30,
                          )
                        : Icon(
                            isCompleted ? Icons.emoji_events : Icons.emoji_events_outlined,
                            color: isCompleted ? AppColors.success : AppColors.xp,
                            size: 30,
                          ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
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
            SizedBox(height: 16),
            DuoProgressBar(
              progress: progressValue,
              progressColor: progressColor,
              backgroundColor: progressColor.withOpacity(0.2),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$progress/$total",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
                ),
                if (reward != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.xp.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      reward!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.xp,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementGrid extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;
  final VoidCallback? onSeeAllTap;

  const AchievementGrid({
    Key? key,
    required this.achievements,
    this.onSeeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Достижения",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            if (onSeeAllTap != null)
              GestureDetector(
                onTap: onSeeAllTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Все",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 16),
        ...achievements.map((achievement) => AchievementCard(
          title: achievement["title"],
          description: achievement["description"],
          progress: achievement["progress"],
          total: achievement["total"],
          iconPath: achievement["icon"],
          reward: achievement["reward"] ?? "${achievement["total"] * 5} XP",
          isCompleted: achievement["progress"] >= achievement["total"],
        )).toList(),
      ],
    );
  }
} 