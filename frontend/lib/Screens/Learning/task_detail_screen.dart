import 'package:devup/Data/data_model.dart';
import 'package:devup/Screens/Learning/course_detail_screen.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetailScreen extends StatefulWidget {
  final Map<String, dynamic> task;
  final String? courseId;
  final String? track;

  const TaskDetailScreen({
    Key? key,
    required this.task,
    this.courseId,
    this.track,
  }) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  int? selectedAnswerIndex;
  bool isAnswerSubmitted = false;
  bool isAnswerCorrect = false;
  String userSolution = "";

  int currentTaskIndex = 2;
  final int totalTasks = 5;

  @override
  void initState() {
    super.initState();
    _determineTaskIndex();
  }

  void _determineTaskIndex() {
    setState(() {
      currentTaskIndex = widget.task["id"].hashCode % totalTasks;
      if (currentTaskIndex < 0) currentTaskIndex = 0;
    });
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
                _buildProgressBar(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      Expanded(
                        child: Text(
                          widget.task["title"] ?? "Задание",
                          style: GoogleFonts.firaCode(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
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
                              "${widget.task["energyCost"] ?? 5}",
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
                ),
                SizedBox(height: 20),
                Expanded(
                  child: _buildTaskContent(),
                ),
                if (!isAnswerSubmitted)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: _submitAnswer,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(15),
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
                            "Отправить ответ",
                            style: GoogleFonts.firaCode(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (isAnswerSubmitted)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColors.textLight,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Назад к списку",
                                  style: GoogleFonts.firaCode(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _goToNextTask();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(15),
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
                                  "Следующее задание",
                                  style: GoogleFonts.firaCode(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
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

  Widget _buildProgressBar() {
    return Container(
      width: double.infinity,
      height: 10,
      child: Row(
        children: List.generate(totalTasks, (index) {
          Color segmentColor;
          if (index < currentTaskIndex) {
            segmentColor = AppColors.success;
          } else if (index == currentTaskIndex) {
            segmentColor = AppColors.primary;
          } else {
            segmentColor = AppColors.textLight.withOpacity(0.3);
          }

          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: segmentColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTaskContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Описание задания",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.task["description"] ??
                      widget.task["problem"] ??
                      "Выполните задание, следуя инструкциям ниже.",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          if (widget.task["codeSnippet"] != null) ...[
            _buildCodeAnalysisSection(),
            SizedBox(height: 20),
          ],
          if (widget.task["examples"] != null) ...[
            _buildExamplesSection(),
            SizedBox(height: 20),
          ],
          if (widget.task["questions"] != null &&
              (widget.task["questions"] as List).isNotEmpty) ...[
            _buildQuestionsSection(),
            SizedBox(height: 20),
          ],
          if (widget.task["type"] == "Задача с развернутым ответом" ||
              widget.task["sampleSolution"] != null) ...[
            _buildSolutionSection(),
            SizedBox(height: 20),
          ],
          if (isAnswerSubmitted) ...[
            _buildResultSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildCodeAnalysisSection() {
    final codeSnippet =
        widget.task["codeSnippet"] ?? "// Код для анализа отсутствует";

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Код для анализа",
            style: GoogleFonts.firaCode(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              codeSnippet,
              style: GoogleFonts.firaCode(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesSection() {
    final examples = widget.task["examples"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Примеры",
          style: GoogleFonts.firaCode(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        if (examples.isEmpty)
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.textLight,
                width: 1,
              ),
            ),
            child: Text(
              "Примеры отсутствуют",
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          ...examples
              .map<Widget>((example) => Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.textLight,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ввод: ${example["input"] ?? ""}",
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Вывод: ${example["output"] ?? ""}",
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (example["explanation"] != null) ...[
                          SizedBox(height: 10),
                          Text(
                            "Объяснение: ${example["explanation"]}",
                            style: GoogleFonts.firaCode(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ))
              .toList(),
      ],
    );
  }

  Widget _buildQuestionsSection() {
    final questions = widget.task["questions"];
    final question = questions != null && questions.isNotEmpty
        ? questions[0]
        : {
            "question": "Вопрос отсутствует",
            "options": [],
            "correctAnswer": -1,
            "explanation": "Объяснение отсутствует"
          };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Вопрос",
          style: GoogleFonts.firaCode(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            question["question"] ?? "Вопрос отсутствует",
            style: GoogleFonts.firaCode(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(height: 15),
        Text(
          "Варианты ответа:",
          style: GoogleFonts.firaCode(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        ...List.generate(
          question["options"]?.length ?? 0,
          (index) => _buildOptionItem(
            index,
            question["options"]?[index] ?? "Вариант отсутствует",
            isAnswerSubmitted ? index == question["correctAnswer"] : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSolutionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ваше решение",
          style: GoogleFonts.firaCode(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: TextField(
            maxLines: 10,
            onChanged: (value) {
              setState(() {
                userSolution = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Введите ваше решение здесь...",
              hintStyle: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textLight,
              ),
              border: InputBorder.none,
            ),
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultSection() {
    if (widget.task["questions"] != null &&
        (widget.task["questions"] as List).isNotEmpty) {
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isAnswerCorrect
              ? AppColors.success.withOpacity(0.2)
              : AppColors.error.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isAnswerCorrect ? AppColors.success : AppColors.error,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isAnswerCorrect ? Icons.check_circle : Icons.cancel,
                  color: isAnswerCorrect ? AppColors.success : AppColors.error,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  isAnswerCorrect ? "Правильно!" : "Неправильно!",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        isAnswerCorrect ? AppColors.success : AppColors.error,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.task["questions"][0]["explanation"] ??
                  "Объяснение отсутствует",
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.xp,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text(
                  isAnswerCorrect
                      ? "+${widget.task["xpReward"] ?? 10} XP"
                      : "+0 XP",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.xp,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.info.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.info,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: AppColors.info,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  "Решение отправлено на проверку",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.info,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Наш AI анализирует ваше решение. Результаты будут доступны в ближайшее время.",
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildOptionItem(int index, String option, bool? isCorrect) {
    final bool isSelected = selectedAnswerIndex == index;

    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (isAnswerSubmitted) {
      if (isCorrect == true) {
        backgroundColor = AppColors.success.withOpacity(0.2);
        borderColor = AppColors.success;
        textColor = AppColors.textPrimary;
      } else if (isSelected && isCorrect == false) {
        backgroundColor = AppColors.error.withOpacity(0.2);
        borderColor = AppColors.error;
        textColor = AppColors.textPrimary;
      } else {
        backgroundColor = AppColors.surface;
        borderColor = AppColors.textLight;
        textColor = AppColors.textPrimary;
      }
    } else {
      if (isSelected) {
        backgroundColor = AppColors.primary.withOpacity(0.2);
        borderColor = AppColors.primary;
        textColor = AppColors.textPrimary;
      } else {
        backgroundColor = AppColors.surface;
        borderColor = AppColors.textLight;
        textColor = AppColors.textPrimary;
      }
    }

    return GestureDetector(
      onTap: isAnswerSubmitted
          ? null
          : () {
              setState(() {
                selectedAnswerIndex = index;
              });
            },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textLight,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                option,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ),
            if (isAnswerSubmitted && isCorrect == true)
              Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 24,
              ),
            if (isAnswerSubmitted && isSelected && isCorrect == false)
              Icon(
                Icons.cancel,
                color: AppColors.error,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  void _submitAnswer() {
    setState(() {
      isAnswerSubmitted = true;

      if (widget.task["questions"] != null &&
          (widget.task["questions"] as List).isNotEmpty) {
        final questions = widget.task["questions"];
        final question =
            questions != null && questions.isNotEmpty ? questions[0] : null;
        isAnswerCorrect = question != null &&
            selectedAnswerIndex == question["correctAnswer"];
      } else {
        isAnswerCorrect = true;
      }

      if (isAnswerCorrect && widget.courseId != null) {
        _updateCourseProgress();
      }
    });
  }

  void _updateCourseProgress() {
    setState(() {
      if (currentTaskIndex < totalTasks - 1) {
        currentTaskIndex++;
      }
    });

    if (widget.courseId != null && Get.isRegistered<CourseDetailScreen>()) {
      try {
        final courseDetailScreen = Get.find<CourseDetailScreen>();
      } catch (e) {
        print("Не удалось обновить прогресс в курсе: $e");
      }
    }
  }

  void _goToNextTask() {
    final String? nextTaskId = widget.task["nextTaskId"];

    if (nextTaskId == null) {
      // Если следующего задания нет, возвращаемся к списку
      Get.back();
      Get.snackbar(
        "Поздравляем!",
        "Вы выполнили все задания в этом модуле!",
        backgroundColor: AppColors.success.withOpacity(0.1),
        colorText: AppColors.textPrimary,
        duration: Duration(seconds: 3),
      );
      return;
    }

    Map<String, dynamic>? nextTask;

    if (widget.task["type"] == "Тест") {
      nextTask = AppData.testTasks.firstWhere(
        (task) => task["id"] == nextTaskId,
        orElse: () => {},
      );
    } else if (widget.task["type"] == "Анализ кода") {
      nextTask = AppData.codeAnalysisTasks.firstWhere(
        (task) => task["id"] == nextTaskId,
        orElse: () => {},
      );
    } else if (widget.task["type"] == "Задача с развернутым ответом") {
      nextTask = AppData.algorithmTasks.firstWhere(
        (task) => task["id"] == nextTaskId,
        orElse: () => {},
      );
    }

    if (nextTask == null || nextTask.isEmpty) {
      for (final taskList in [
        AppData.testTasks,
        AppData.codeAnalysisTasks,
        AppData.algorithmTasks
      ]) {
        final found = taskList.firstWhere(
          (task) => task["id"] == nextTaskId,
          orElse: () => {},
        );
        if (found.isNotEmpty) {
          nextTask = found;
          break;
        }
      }
    }

    if (nextTask != null && nextTask.isNotEmpty) {
      Get.off(
        () => TaskDetailScreen(
          task: nextTask!,
          courseId: widget.courseId,
          track: widget.track,
        ),
      );
    } else {
      Get.back();
      Get.snackbar(
        "Информация",
        "Следующее задание не найдено",
        backgroundColor: AppColors.info.withOpacity(0.1),
        colorText: AppColors.textPrimary,
        duration: Duration(seconds: 3),
      );
    }
  }
}
