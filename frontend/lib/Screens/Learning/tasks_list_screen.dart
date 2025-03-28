import 'package:devup/Data/data_model.dart';
import 'package:devup/Screens/Learning/task_detail_screen.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:devup/widgets/Learning/task_path_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TasksListScreen extends StatefulWidget {
  final String track;
  final String? courseId;
  final String? taskId;

  const TasksListScreen(
      {Key? key, required this.track, this.courseId, this.taskId})
      : super(key: key);

  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  final double trackCompletionPercentage = 0.35;
  final int completedModules = 2;
  final int totalModules = 6;
  final int earnedXP = 450;

  int selectedModuleIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.taskId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openTaskById(widget.taskId!);
      });
    }
  }

  void _openTaskById(String taskId) {
    Map<String, dynamic>? task;

    task = AppData.testTasks.firstWhere(
      (t) => t["id"] == taskId,
      orElse: () => {},
    );

    if (task == null || task.isEmpty) {
      task = AppData.codeAnalysisTasks.firstWhere(
        (t) => t["id"] == taskId,
        orElse: () => {},
      );
    }

    if (task == null || task.isEmpty) {
      task = AppData.algorithmTasks.firstWhere(
        (t) => t["id"] == taskId,
        orElse: () => {},
      );
    }

    if (task != null && task.isNotEmpty) {
      Get.to(() => TaskDetailScreen(
            task: task!,
            courseId: widget.courseId,
            track: widget.track,
          ));
    }
  }

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
                _buildHeader(),
                SizedBox(height: 20),
                _buildTrackProgressCard(),
                SizedBox(height: 20),
                _buildModuleSelector(),
                SizedBox(height: 20),
                Expanded(
                  child: _buildTasksList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Курс",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  widget.track,
                  style: GoogleFonts.firaCode(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
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
                Icon(
                  Icons.bolt,
                  color: AppColors.energy,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  "25",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackProgressCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5B5FEF), Color(0xFF00C9B1)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5B5FEF).withOpacity(0.3),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ваш прогресс",
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "$completedModules из $totalModules модулей",
                    style: GoogleFonts.firaCode(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "$earnedXP XP",
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          LinearPercentIndicator(
            lineHeight: 10.0,
            percent: trackCompletionPercentage,
            backgroundColor: Colors.white.withOpacity(0.3),
            progressColor: Colors.white,
            barRadius: Radius.circular(5),
            padding: EdgeInsets.zero,
            animation: true,
            animationDuration: 1000,
          ),
          SizedBox(height: 10),
          Text(
            "${(trackCompletionPercentage * 100).toInt()}% завершено",
            style: GoogleFonts.firaCode(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleSelector() {
    List<String> modules = [
      "Модуль 1: Основы",
      "Модуль 2: Функции",
      "Модуль 3: Объекты",
      "Модуль 4: Асинхронность",
      "Модуль 5: React",
      "Модуль 6: Проект",
    ];

    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedModuleIndex == index;
          bool isCompleted = index < completedModules;
          bool isLocked = index > completedModules;

          return GestureDetector(
            onTap: isLocked
                ? null
                : () {
                    setState(() {
                      selectedModuleIndex = index;
                    });
                  },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : isLocked
                        ? AppColors.surface.withOpacity(0.5)
                        : AppColors.surface,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : isCompleted
                          ? AppColors.success.withOpacity(0.3)
                          : Colors.transparent,
                  width: 1,
                ),
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
              child: Center(
                child: Row(
                  children: [
                    if (isCompleted && !isSelected)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 16,
                      ),
                    if (isLocked)
                      Icon(
                        Icons.lock,
                        color: AppColors.textLight,
                        size: 16,
                      ),
                    if ((isCompleted && !isSelected) || isLocked)
                      SizedBox(width: 5),
                    Text(
                      "Модуль ${index + 1}",
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : isLocked
                                ? AppColors.textLight
                                : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTasksList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        _buildSectionTitle("Теория", Icons.menu_book),
        SizedBox(height: 10),
        _buildTheoryCard(
          title: "Введение в JavaScript",
          duration: "15 мин",
          isCompleted: true,
        ),
        SizedBox(height: 15),
        _buildTheoryCard(
          title: "Переменные и типы данных",
          duration: "20 мин",
          isCompleted: true,
        ),
        SizedBox(height: 15),
        _buildTheoryCard(
          title: "Операторы и выражения",
          duration: "25 мин",
          isCompleted: false,
        ),
        SizedBox(height: 30),
        _buildSectionTitle("Практика", Icons.code),
        SizedBox(height: 10),
        _buildTaskCard(
          title: "Переменные и типы данных",
          difficulty: "Легкий",
          type: "Тест",
          xp: 10,
          energy: 2,
          isCompleted: true,
          task: AppData.testTasks[0],
        ),
        SizedBox(height: 15),
        _buildTaskCard(
          title: "Работа с числами",
          difficulty: "Легкий",
          type: "Задача",
          xp: 15,
          energy: 3,
          isCompleted: true,
          task: AppData.algorithmTasks[0],
        ),
        SizedBox(height: 15),
        _buildTaskCard(
          title: "Условные операторы",
          difficulty: "Средний",
          type: "Анализ кода",
          xp: 20,
          energy: 4,
          isCompleted: false,
          task: AppData.codeAnalysisTasks[0],
        ),
        SizedBox(height: 30),
        _buildSectionTitle("Проект модуля", Icons.assignment),
        SizedBox(height: 10),
        _buildProjectCard(
          title: "Калькулятор на JavaScript",
          description:
              "Создайте простой калькулятор с использованием HTML, CSS и JavaScript",
          xp: 50,
          isLocked: selectedModuleIndex < 1,
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.firaCode(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTheoryCard({
    required String title,
    required String duration,
    required bool isCompleted,
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isCompleted ? Icons.check : Icons.menu_book,
                color: isCompleted ? AppColors.success : AppColors.primary,
                size: 20,
              ),
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Время чтения: $duration",
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
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String difficulty,
    required String type,
    required int xp,
    required int energy,
    required bool isCompleted,
    required Map<String, dynamic> task,
  }) {
    Color difficultyColor;
    if (difficulty == "Легкий") {
      difficultyColor = AppColors.success;
    } else if (difficulty == "Средний") {
      difficultyColor = AppColors.warning;
    } else {
      difficultyColor = AppColors.error;
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => TaskDetailScreen(
              task: task,
              courseId: widget.courseId,
              track: widget.track,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isCompleted
                ? AppColors.success.withOpacity(0.3)
                : Colors.transparent,
            width: 1,
          ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        difficulty,
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: difficultyColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        type,
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (isCompleted)
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: AppColors.success,
                      size: 16,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.firaCode(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "$xp XP",
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.bolt,
                      color: AppColors.energy,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "$energy",
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
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String description,
    required int xp,
    required bool isLocked,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isLocked ? AppColors.surface.withOpacity(0.7) : AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isLocked
              ? Colors.transparent
              : AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isLocked ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
              if (isLocked)
                Icon(
                  Icons.lock,
                  color: AppColors.textLight,
                  size: 20,
                ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: isLocked ? AppColors.textLight : AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(
                Icons.star,
                color: isLocked ? AppColors.textLight : Colors.amber,
                size: 16,
              ),
              SizedBox(width: 5),
              Text(
                "$xp XP",
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isLocked ? AppColors.textLight : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllTasksPath() {
    // Этот метод больше не используется, так как мы изменили структуру экрана
    // Сохраняем его временно для обратной совместимости

    // Объединяем все задания из разных категорий
    List<Map<String, dynamic>> allTasks = [
      ...AppData.testTasks,
      ...AppData.codeAnalysisTasks,
      ...AppData.algorithmTasks,
    ];

    // Фильтрация задач по выбранному направлению
    final filteredTasks = allTasks.where((task) {
      final matchesTrack = task["track"] == widget.track;
      return matchesTrack;
    }).toList();

    // Если нет доступных заданий, показываем сообщение
    if (filteredTasks.isEmpty) {
      return Center(
        child: Text(
          "Нет доступных заданий",
          style: GoogleFonts.firaCode(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    // Добавляем статус выполнения и блокировки для демонстрации
    for (int i = 0; i < filteredTasks.length; i++) {
      // Первые два задания разблокированы, первое выполнено
      if (i == 0) {
        filteredTasks[i]["completed"] = true;
        filteredTasks[i]["locked"] = false;
      } else if (i == 1) {
        filteredTasks[i]["completed"] = false;
        filteredTasks[i]["locked"] = false;
      } else {
        // Остальные задания заблокированы
        filteredTasks[i]["completed"] = false;
        filteredTasks[i]["locked"] = true;
      }
    }

    return TaskPathWidget(
      track: widget.track,
      tasks: filteredTasks,
      category: "Все",
    );
  }
}
