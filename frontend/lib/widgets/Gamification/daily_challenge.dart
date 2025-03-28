import 'package:flutter/material.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/Gamification/progress_bar.dart';

class DailyChallenge extends StatelessWidget {
  final String title;
  final String reward;
  final int progress;
  final int total;
  final IconData icon;
  final VoidCallback? onTap;

  const DailyChallenge({
    Key? key,
    required this.title,
    required this.reward,
    required this.progress,
    required this.total,
    this.icon = Icons.task_alt,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progressValue = progress / total;
    final bool isCompleted = progress >= total;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCompleted 
                        ? AppColors.success.withOpacity(0.2) 
                        : AppColors.warning.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: isCompleted ? AppColors.success : AppColors.warning,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
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
                        "Награда: $reward",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.xp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isCompleted 
                        ? AppColors.success.withOpacity(0.2) 
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: isCompleted 
                        ? null 
                        : Border.all(color: AppColors.warning, width: 1),
                  ),
                  child: Text(
                    "$progress/$total",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? AppColors.success : AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            DuoProgressBar(
              progress: progressValue,
              progressColor: isCompleted ? AppColors.success : AppColors.warning,
              backgroundColor: (isCompleted ? AppColors.success : AppColors.warning).withOpacity(0.2),
            ),
            if (!isCompleted) ...[
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warning,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.warning.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Выполнить",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class DailyStreak extends StatelessWidget {
  final int streak;
  final List<bool> weekProgress;

  const DailyStreak({
    Key? key,
    required this.streak,
    required this.weekProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
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
                      "$streak дней подряд",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Продолжайте заниматься каждый день!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
              (index) => _buildDayIndicator(
                day: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"][index],
                isCompleted: index < weekProgress.length ? weekProgress[index] : false,
                isToday: index == weekProgress.length - 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayIndicator({
    required String day,
    required bool isCompleted,
    required bool isToday,
  }) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.white
                : Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: isToday
                ? Border.all(
                    color: Colors.white,
                    width: 2,
                  )
                : null,
          ),
          child: isCompleted
              ? Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: 20,
                )
              : null,
        ),
        SizedBox(height: 4),
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
} 