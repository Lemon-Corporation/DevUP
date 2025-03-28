import 'package:flutter/material.dart';
import 'package:devup/Values/values.dart';

class DuoProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color progressColor;
  final Color backgroundColor;
  final bool showPercentage;
  final String? label;
  final bool animate;

  const DuoProgressBar({
    Key? key,
    required this.progress,
    this.height = 12.0,
    this.progressColor = const Color(0xFF58CC02),
    this.backgroundColor = const Color(0xFFE5E5E5),
    this.showPercentage = false,
    this.label,
    this.animate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
        ],
        Stack(
          children: [
            // Background
            Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
            // Progress
            AnimatedContainer(
              duration: animate ? Duration(milliseconds: 800) : Duration.zero,
              curve: Curves.easeInOut,
              height: height,
              width: MediaQuery.of(context).size.width * progress,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(height / 2),
                boxShadow: [
                  BoxShadow(
                    color: progressColor.withOpacity(0.4),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            // Dots
            if (progress > 0.05)
              Container(
                height: height,
                width: MediaQuery.of(context).size.width * progress,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    5,
                    (index) => Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (showPercentage) ...[
          SizedBox(height: 4),
          Text(
            "${(progress * 100).toInt()}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: progressColor,
            ),
          ),
        ],
      ],
    );
  }
}

class DuoLevelProgress extends StatelessWidget {
  final int currentXP;
  final int xpToNextLevel;
  final int level;
  final double height;

  const DuoLevelProgress({
    Key? key,
    required this.currentXP,
    required this.xpToNextLevel,
    required this.level,
    this.height = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = currentXP / xpToNextLevel;
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$level",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Уровень $level",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.xp.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.xp,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "$currentXP XP",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.xp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          DuoProgressBar(
            progress: progress,
            height: height,
            progressColor: AppColors.xp,
            backgroundColor: AppColors.xp.withOpacity(0.2),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Прогресс",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                "$currentXP / $xpToNextLevel XP до уровня ${level + 1}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 