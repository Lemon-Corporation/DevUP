import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Data/data_model.dart';
import 'package:devup/Data/js_test_data.dart';
import 'package:devup/Screens/Learning/task_detail_screen.dart';
import 'package:devup/Screens/Learning/intro_to_js_page.dart';
import 'package:devup/Screens/Learning/variables_types_page.dart';
import 'package:devup/Screens/Learning/operators_expressions_page.dart';
import 'package:devup/Screens/Learning/enhanced_test_screen.dart';
import 'package:devup/Screens/Learning/functions_page.dart';
import 'package:devup/Screens/Learning/closures_page.dart';
import 'package:devup/Screens/Learning/form_validation_project.dart';
import 'package:devup/Screens/Learning/guess_number_game.dart';
import 'package:devup/Screens/Learning/objects_theory_page.dart';
import 'package:devup/Screens/Learning/arrays_theory_page.dart';
import 'package:devup/Screens/Learning/destructuring_theory_page.dart';
import 'package:devup/Screens/Learning/objects_practice_easy.dart';
import 'package:devup/Screens/Learning/arrays_practice_medium.dart';
import 'package:devup/Screens/Learning/todo_app_project.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:devup/widgets/Learning/task_path_widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:devup/Services/progress_manager.dart';

class TasksListScreen extends StatefulWidget {
  final String track;
  final String? courseId;
  final String? taskId;

  const TasksListScreen({Key? key, required this.track, this.courseId, this.taskId}) : super(key: key);

  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  // Track progress data - теперь получаем из ProgressManager
  double get trackCompletionPercentage => ProgressManager.getCurrentProgress();
  final int completedModules = 3;
  final int totalModules = 6;
  int get earnedXP => ProgressManager.getCurrentXP();
  
  // Current selected module
  int selectedModuleIndex = 0;
  
  // Состояние прохождения тестов
  Map<String, bool> completedTests = {
    // Модуль 1
    'js_variables_test': false,
    'js_operators_test': false,
    'js_variables_code': false,
    'js_operators_code': false,
    // Модуль 2
    'js_functions_test': false,
    'js_closures_test': false,
    'js_functions_code': false,
    // Модуль 3
    'js_objects_test': false,
    'js_arrays_test': false,
    'js_destructuring_test': false,
    'js_objects_arrays_code': false,
  };
  
  @override
  void initState() {
    super.initState();
    
    // Определяем текущий модуль на основе прогресса
    _setCurrentModuleBasedOnProgress();
    
    // Обновляем состояние завершенных тестов из ProgressManager
    _updateCompletedTests();
    
    // Если передан taskId, открываем соответствующее задание
    if (widget.taskId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openTaskById(widget.taskId!);
      });
    }
  }
  
  void _setCurrentModuleBasedOnProgress() {
    // Простая логика: каждый модуль = ~16.67% прогресса (100% / 6 модулей)
    double progress = trackCompletionPercentage;
    int calculatedModule = (progress * 6).floor().clamp(0, totalModules - 1);
    
    // Если прогресс больше 35%, переходим к модулю 3 (так как мы его разблокировали)
    if (progress >= 0.35) {
      calculatedModule = 2; // Модуль 3 (индекс 2)
    }
    
    // Убеждаемся, что модуль не заблокирован
    if (calculatedModule <= completedModules) {
      selectedModuleIndex = calculatedModule;
    }
  }
  
  void _updateCompletedTests() {
    setState(() {
      // Модуль 1
      completedTests['js_variables_test'] = ProgressManager.isTestCompleted('js_variables_test');
      completedTests['js_operators_test'] = ProgressManager.isTestCompleted('js_operators_test');
      completedTests['js_variables_code'] = ProgressManager.isTestCompleted('js_variables_code');
      completedTests['js_operators_code'] = ProgressManager.isTestCompleted('js_operators_code');
      
      // Модуль 2
      completedTests['js_functions_test'] = ProgressManager.isTestCompleted('js_functions_test');
      completedTests['js_closures_test'] = ProgressManager.isTestCompleted('js_closures_test');
      completedTests['js_functions_code'] = ProgressManager.isTestCompleted('js_functions_code');
      
      // Модуль 3
      completedTests['js_objects_test'] = ProgressManager.isTestCompleted('js_objects_test');
      completedTests['js_arrays_test'] = ProgressManager.isTestCompleted('js_arrays_test');
      completedTests['js_destructuring_test'] = ProgressManager.isTestCompleted('js_destructuring_test');
      completedTests['js_objects_arrays_code'] = ProgressManager.isTestCompleted('js_objects_arrays_code');
    });
  }
  
  // Метод для открытия задания по ID
  void _openTaskById(String taskId) {
    // Ищем задание во всех списках
    Map<String, dynamic>? task;
    
    // Проверяем в списке тестовых заданий
    task = AppData.testTasks.firstWhere(
      (t) => t["id"] == taskId,
      orElse: () => {},
    );
    
    // Если не нашли, проверяем в списке заданий на анализ кода
    if (task == null || task.isEmpty) {
      task = AppData.codeAnalysisTasks.firstWhere(
        (t) => t["id"] == taskId,
        orElse: () => {},
      );
    }
    
    // Если не нашли, проверяем в списке алгоритмических задач
    if (task == null || task.isEmpty) {
      task = AppData.algorithmTasks.firstWhere(
        (t) => t["id"] == taskId,
        orElse: () => {},
      );
    }
    
    // Если задание найдено, открываем его
    if (task != null && task.isNotEmpty) {
      Get.to(() => TaskDetailScreen(
        task: task!,
        courseId: widget.courseId,
        track: widget.track,
      ));
    }
  }

  bool _areAllTestsCompleted() {
    return completedTests.values.every((completed) => completed);
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
            onTap: isLocked ? null : () {
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
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ] : null,
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
    if (selectedModuleIndex == 0) {
      return _buildModule1Tasks();
    } else if (selectedModuleIndex == 1) {
      return _buildModule2Tasks();
    } else if (selectedModuleIndex == 2) {
      return _buildModule3Tasks();
    } else {
      return _buildComingSoonModule();
    }
  }

  Widget _buildModule1Tasks() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        _buildSectionTitle("Теория", Icons.menu_book),
        SizedBox(height: 10),
        _buildTheoryCard(
          title: "Введение в JavaScript",
          duration: "15 мин",
          isCompleted: true,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IntroToJsPage()),
          ),
        ),
        SizedBox(height: 15),
        _buildTheoryCard(
          title: "Переменные и типы данных",
          duration: "20 мин",
          isCompleted: true,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VariablesTypesPage()),
          ),
        ),
        SizedBox(height: 15),
        _buildTheoryCard(
          title: "Операторы и выражения",
          duration: "25 мин",
          isCompleted: false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OperatorsExpressionsPage()),
          ),
        ),
        
        SizedBox(height: 30),
        _buildSectionTitle("Практика", Icons.code),
        SizedBox(height: 10),
        
        // Новые тесты JavaScript
        _buildEnhancedTestCard(
          testData: JSTestData.variablesTypesTest,
          isCompleted: completedTests['js_variables_test'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.operatorsTest,
          isCompleted: completedTests['js_operators_test'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.variablesCodeAnalysis,
          isCompleted: completedTests['js_variables_code'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.operatorsCodeAnalysis,
          isCompleted: completedTests['js_operators_code'] ?? false,
        ),
        
        SizedBox(height: 30),
        _buildSectionTitle("Проект модуля", Icons.assignment),
        SizedBox(height: 10),
        
        _buildProjectCard(
          title: "Форма валидации",
          description: "Создайте интерактивную форму регистрации с валидацией полей",
          xp: 40,
          isLocked: !_areAllTestsCompleted(),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormValidationProject()),
          ),
        ),
        
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildModule2Tasks() {
    // Состояние прохождения тестов второго модуля
    Map<String, bool> module2Tests = {
      'js_functions_test': ProgressManager.isTestCompleted('js_functions_test'),
      'js_closures_test': ProgressManager.isTestCompleted('js_closures_test'),
      'js_functions_code': ProgressManager.isTestCompleted('js_functions_code'),
    };

    bool areAllModule2TestsCompleted = module2Tests.values.every((completed) => completed);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        _buildSectionTitle("Теория", Icons.menu_book),
        SizedBox(height: 10),
        _buildTheoryCard(
          title: "Функции в JavaScript",
          duration: "30 мин",
          isCompleted: false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FunctionsPage()),
          ),
        ),
        SizedBox(height: 15),
        _buildTheoryCard(
          title: "Замыкания и область видимости",
          duration: "35 мин",
          isCompleted: false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ClosuresPage()),
          ),
        ),
        
        SizedBox(height: 30),
        _buildSectionTitle("Практика", Icons.code),
        SizedBox(height: 10),
        
        // Тесты второго модуля
        _buildEnhancedTestCard(
          testData: JSTestData.functionsTest,
          isCompleted: module2Tests['js_functions_test'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.closuresTest,
          isCompleted: module2Tests['js_closures_test'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.functionsCodeAnalysis,
          isCompleted: module2Tests['js_functions_code'] ?? false,
        ),
        
        SizedBox(height: 30),
        _buildSectionTitle("Проект модуля", Icons.assignment),
        SizedBox(height: 10),
        
        _buildProjectCard(
          title: "Игра \"Угадай число\"",
          description: "Создайте интерактивную игру с использованием функций, замыканий и модульного паттерна",
          xp: 50,
          isLocked: !areAllModule2TestsCompleted,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GuessNumberGame()),
          ),
        ),
        
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildModule3Tasks() {
    // Состояние прохождения тестов третьего модуля
    Map<String, bool> module3Tests = {
      'js_objects_test': ProgressManager.isTestCompleted('js_objects_test'),
      'js_arrays_test': ProgressManager.isTestCompleted('js_arrays_test'),
      'js_destructuring_test': ProgressManager.isTestCompleted('js_destructuring_test'),
    };

    // Состояние прохождения уроков третьего модуля
    Map<String, bool> module3Lessons = {
      'objects_theory': ProgressManager.isLessonCompleted('objects_theory'),
      'arrays_theory': ProgressManager.isLessonCompleted('arrays_theory'),
      'destructuring_theory': ProgressManager.isLessonCompleted('destructuring_theory'),
    };

    bool areAllModule3TestsCompleted = module3Tests.values.every((completed) => completed);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        _buildSectionTitle("Теория", Icons.menu_book),
        SizedBox(height: 10),
        _buildTheoryCard(
          title: "Объекты в JavaScript",
          duration: "30 мин",
          isCompleted: module3Lessons['objects_theory'] ?? false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ObjectsTheoryPage()),
          ),
        ),
        SizedBox(height: 15),
        _buildTheoryCard(
          title: "Массивы и методы массивов",
          duration: "35 мин",
          isCompleted: module3Lessons['arrays_theory'] ?? false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ArraysTheoryPage()),
          ),
        ),
        SizedBox(height: 15),
        _buildTheoryCard(
          title: "Деструктуризация и spread оператор",
          duration: "25 мин",
          isCompleted: module3Lessons['destructuring_theory'] ?? false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DestructuringTheoryPage()),
          ),
        ),
        
        SizedBox(height: 30),
        _buildSectionTitle("Тесты", Icons.quiz),
        SizedBox(height: 10),
        
        // Тесты модуля 3
        _buildEnhancedTestCard(
          testData: JSTestData.objectsTest,
          isCompleted: module3Tests['js_objects_test'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.arraysTest,
          isCompleted: module3Tests['js_arrays_test'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.destructuringTest,
          isCompleted: module3Tests['js_destructuring_test'] ?? false,
        ),
        SizedBox(height: 15),
        
        _buildEnhancedTestCard(
          testData: JSTestData.objectsArraysCodeAnalysis,
          isCompleted: ProgressManager.isTestCompleted('js_objects_arrays_code'),
        ),
        
        SizedBox(height: 30),
        _buildSectionTitle("Практика", Icons.code),
        SizedBox(height: 10),
        
        // Практические задания модуля 3
        _buildPracticeCard(
          title: "Практика: Объекты (Легко)",
          description: "Основы работы с объектами JavaScript",
          xp: 30,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ObjectsPracticeEasy()),
          ),
        ),
        SizedBox(height: 15),
        
        _buildPracticeCard(
          title: "Практика: Массивы (Средне)",
          description: "Методы массивов и функциональное программирование",
          xp: 50,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ArraysPracticeMedium()),
          ),
        ),
        
        SizedBox(height: 30),
        _buildSectionTitle("Проект модуля", Icons.assignment),
        SizedBox(height: 10),
        
        _buildProjectCard(
          title: "Todo приложение",
          description: "Создайте полнофункциональное приложение для управления задачами",
          xp: 100,
          isLocked: !areAllModule3TestsCompleted,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoAppProject()),
          ),
        ),
        
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildComingSoonModule() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 80,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 20),
          Text(
            'Модуль в разработке',
            style: GoogleFonts.firaCode(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Скоро здесь появятся новые уроки!',
            style: GoogleFonts.firaCode(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                color: isCompleted ? AppColors.success.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
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
      ),
    );
  }

  Widget _buildEnhancedTestCard({
    required Map<String, dynamic> testData,
    required bool isCompleted,
  }) {
    final difficulty = testData['difficulty'] as String;
    final type = testData['type'] as String;
    final xp = testData['xpReward'] as int;
    final energy = testData['energyCost'] as int;
    final title = testData['title'] as String;
    final questionCount = (testData['questions'] as List).length;

    Color difficultyColor;
    if (difficulty == "Легкий") {
      difficultyColor = AppColors.success;
    } else if (difficulty == "Средний") {
      difficultyColor = AppColors.warning;
    } else {
      difficultyColor = AppColors.error;
    }

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnhancedTestScreen(
              testData: testData,
              courseId: widget.courseId ?? '',
              track: widget.track,
            ),
          ),
        );
        
        // Обновляем состояние если тест пройден
        if (result == true) {
          _updateCompletedTests(); // Обновляем все состояния из ProgressManager
        }
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isCompleted ? AppColors.success.withOpacity(0.3) : Colors.transparent,
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
            SizedBox(height: 8),
            Text(
              "$questionCount вопросов • ${testData['description']}",
              style: GoogleFonts.firaCode(
                fontSize: 12,
                color: AppColors.textSecondary,
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

  Widget _buildPracticeCard({
    required String title,
    required String description,
    required int xp,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.code,
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
                    title,
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: GoogleFonts.firaCode(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "$xp XP",
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
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

  Widget _buildProjectCard({
    required String title,
    required String description,
    required int xp,
    required bool isLocked,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
          color: isLocked ? AppColors.surface.withOpacity(0.7) : AppColors.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
            color: isLocked ? Colors.transparent : AppColors.primary.withOpacity(0.3),
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
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.firaCode(
                    fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isLocked ? AppColors.textLight : AppColors.textPrimary,
                      ),
                    ),
                ),
                if (isLocked)
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.lock,
                          color: AppColors.warning,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Завершите тесты',
                          style: GoogleFonts.firaCode(
                            fontSize: 10,
                            color: AppColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
                SizedBox(width: 20),
                Icon(
                  Icons.code,
                  color: isLocked ? AppColors.textLight : AppColors.primary,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  "Проект",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isLocked ? AppColors.textLight : AppColors.primary,
                  ),
                ),
            ],
          ),
          ],
        ),
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