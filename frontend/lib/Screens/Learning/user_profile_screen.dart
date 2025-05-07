import 'package:devup/Data/data_model.dart';
import 'package:devup/Screens/Profile/edit_profile.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final DateTime kToday = DateTime(2025, 3, 26);

final List<int> userActivityLast91Days = [
  0,
  3,
  3,
  3,
  4,
  3,
  8,
  4,
  1,
  20,
  1,
  2,
  1,
  0,
  0,
  2,
  2,
  4,
  3,
  4,
  12,
  10,
  2,
  1,
  2,
  3,
  2,
  0,
  3,
  0,
  4,
  0,
  1,
  1,
  1,
  0,
  0,
  3,
  5,
  2,
  2,
  3,
  2,
  1,
  3,
  0,
  5,
  3,
  4,
  3,
  3,
  4,
  1,
  2,
  0,
  1,
  3,
  4,
  0,
  0,
  5,
  4,
  5,
  0,
  4,
  0,
  1,
  1,
  4,
  3,
  1,
  2,
  1,
  0,
  3,
  2,
  2,
  4,
  0,
  0,
  5,
  1,
  1,
  5,
  1,
  0,
  3,
  3,
  3,
  2,
  2,
  0,
  0,
  4,
  4,
  5,
  2,
  0
];

class UserProfileScreen extends StatelessWidget {
  final DateTime startDate = DateTime(2025, 1, 1);

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
                  _buildHeaderBar(),
                  SizedBox(height: 20),
                  _buildUserHeader(),
                  SizedBox(height: 20),
                  _buildStatsSection(),
                  SizedBox(height: 20),
                  _buildActivityTracker(context),
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

  Widget _buildHeaderBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 15),
          Text(
            "Профиль",
            style: TextStyle(
              fontFamily: 'Unbounded',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
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
                "UR",
                style: TextStyle(
                  fontFamily: 'Unbounded',
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "My Username",
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8),
                    // небольшое пространство между именем и иконкой
                    GestureDetector(
                      onTap: () {
                        Get.to(() => EditProfilePage());
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Junior Frontend Developer",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
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
                      style: TextStyle(
                        fontFamily: 'Montserrat',
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
            style: TextStyle(
              fontFamily: 'Unbounded',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                  child:
                      _buildStatCard(Icons.star, "1250", "XP", AppColors.xp)),
              SizedBox(width: 15),
              Expanded(
                  child: _buildStatCard(
                      Icons.bolt, "25", "Энергия", AppColors.energy)),
              SizedBox(width: 15),
              Expanded(
                  child: _buildStatCard(Icons.check_circle, "42", "Задания",
                      AppColors.secondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon, String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 10),
          Text(value,
              style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          SizedBox(height: 5),
          Text(label,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildActivityTracker(BuildContext context) {
    final int totalWeeks = 13;
    final int daysInWeek = 7;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ваша активность",
              style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary)),
          SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildMonthLabelsRow(totalWeeks, daysInWeek),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildDaysOfWeekLabels(daysInWeek),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(totalWeeks, (weekIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Column(
                        children: List.generate(daysInWeek, (dayIndex) {
                          final int index = weekIndex * daysInWeek + dayIndex;
                          final int tasksDone = userActivityLast91Days[index];
                          final Color color = _getColorForActivity(tasksDone);
                          final date = startDate.add(Duration(days: index));

                          final String tooltipText = (tasksDone == 0)
                              ? "No contributions on ${_formatDate(date)}"
                              : "$tasksDone contributions on ${_formatDate(date)}";

                          return Tooltip(
                            message: tooltipText,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            textStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                            preferBelow: false,
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMonthLabelsRow(int totalWeeks, int daysInWeek) {
    List<Widget> labels = [];
    DateTime? previousDate;

    labels.add(const SizedBox(width: 42));

    for (int weekIndex = 0; weekIndex < totalWeeks; weekIndex++) {
      final dayOffset = weekIndex * daysInWeek;
      final date = startDate.add(Duration(days: dayOffset + 3));

      bool showLabel = previousDate == null || previousDate.month != date.month;

      labels.add(Container(
        width: 26,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(right: 6),
        child: showLabel
            ? Text(_formatMonth(date),
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: AppColors.textSecondary))
            : const SizedBox.shrink(),
      ));

      previousDate = date;
    }

    return Row(children: labels);
  }

  Widget _buildDaysOfWeekLabels(int daysInWeek) {
    List<Widget> labels = [];
    for (int dayIndex = 0; dayIndex < daysInWeek; dayIndex++) {
      String text;
      switch (dayIndex) {
        case 0:
          text = "M";
          break;
        case 2:
          text = "W";
          break;
        case 4:
          text = "F";
          break;
        case 6:
          text = "S";
          break;
        default:
          text = "";
          break;
      }

      labels.add(Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(bottom: 6),
        alignment: Alignment.centerRight,
        child: Text(text,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: AppColors.textSecondary)),
      ));
    }

    return Column(children: labels);
  }

  String _formatMonth(DateTime date) {
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[date.month - 1];
  }

  String _formatDate(DateTime date) {
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    final monthName = months[date.month - 1];
    final day = date.day;
    final suffix = _getDaySuffix(day);
    return "$monthName $day$suffix";
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return "th";
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }

  Color _getColorForActivity(int tasksDone) {
    if (tasksDone == 0) return Colors.grey[300]!;
    if (tasksDone == 1) return Colors.blue[100]!;
    if (tasksDone == 2) return Colors.blue[200]!;
    if (tasksDone == 3) return Colors.blue[300]!;
    if (tasksDone == 4) return Colors.blue[400]!;
    if (tasksDone == 5) return Colors.blue[600]!;
    return Colors.blue[900]!;
  }

  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Прогресс по направлениям",
            style: TextStyle(
              fontFamily: 'Unbounded',
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
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
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
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: progressColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  progress["rating"],
                  style: TextStyle(
                    fontFamily: 'Montserrat',
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
            style: TextStyle(
              fontFamily: 'Montserrat',
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
            style: TextStyle(
              fontFamily: 'Unbounded',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
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
                    _buildAchievementItem("🔥", "7 дней подряд", true),
                    _buildAchievementItem("🧠", "10 задач", true),
                    _buildAchievementItem("🏆", "Первый тест", true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String emoji, String title, bool isUnlocked) {
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
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
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
          Text(
            "Ежедневные челленджи",
            style: TextStyle(
              fontFamily: 'Unbounded',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 15),
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
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
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
            offset: const Offset(0, 2),
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
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.xp, size: 16),
                        SizedBox(width: 5),
                        Text(
                          challenge["reward"],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: AppColors.success, size: 20),
                ),
            ],
          ),
          SizedBox(height: 15),
          // Прогресс-бар
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
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                isCompleted ? "Выполнено" : "В процессе",
                style: TextStyle(
                  fontFamily: 'Montserrat',
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
