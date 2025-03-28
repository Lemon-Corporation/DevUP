import 'package:devup/Data/data_model.dart';
import 'package:devup/Screens/Learning/course_detail_screen.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackSelectionScreen extends StatefulWidget {
  @override
  _TrackSelectionScreenState createState() => _TrackSelectionScreenState();
}

class _TrackSelectionScreenState extends State<TrackSelectionScreen> {
  String selectedLevel = "Junior";
  String selectedTrack = "";

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
                          color: Color(0xFF6200EE),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Выбор направления",
                        style: GoogleFonts.firaCode(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Выберите уровень",
                    style: GoogleFonts.firaCode(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      _buildLevelButton("Junior", selectedLevel == "Junior"),
                      SizedBox(width: 15),
                      _buildLevelButton("Middle", selectedLevel == "Middle"),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Выберите направление",
                    style: GoogleFonts.firaCode(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: AppData.programmingTracks.length,
                    itemBuilder: (context, index) {
                      final track = AppData.programmingTracks[index];
                      final isTrackForSelectedLevel =
                          track.startsWith(selectedLevel);

                      if (!isTrackForSelectedLevel) {
                        return SizedBox.shrink();
                      }

                      return _buildTrackCard(track);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelButton(String level, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLevel = level;
          selectedTrack = "";
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(30),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          level,
          style: GoogleFonts.firaCode(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTrackCard(String track) {
    final isSelected = selectedTrack == track;
    final String emoji = track.contains("Frontend") ? "🖥️" : "🗄️";

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTrack = track;
        });

        Future.delayed(Duration(milliseconds: 300), () {
          final courseId = track == "Junior Frontend (React)"
              ? "junior-frontend"
              : "junior-backend-django";
          Get.to(() => CourseDetailScreen(courseId: courseId));
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              emoji,
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
                    track,
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    track.contains("Frontend")
                        ? "Фронтенд-разработка с использованием React"
                        : track.contains("Django")
                            ? "Бэкенд-разработка с использованием Django"
                            : "Бэкенд-разработка с использованием Spring",
                    style: GoogleFonts.firaCode(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
