import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../Data/models/course_model.dart';
import '../../Data/models/module_model.dart';
import '../../Data/models/lesson_model.dart';
import '../../Data/services/data_service.dart';
import '../../Utils/app_extensions.dart';
import 'tasks_list_screen.dart';
import 'lesson_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;

  const CourseDetailScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Course? _course;
  double _completionPercentage = 0.0;
  
  @override
  void initState() {
    super.initState();
    _loadCourseData();
  }
  
  void _loadCourseData() {
    // Создаем JavaScript курс
    final course = Course.createJavaScriptCourse();
    setState(() {
      _course = course;
      _completionPercentage = 0.0;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (_course == null) {
      // Add a fallback to use static method after 2 seconds if DataService failed
      Future.delayed(Duration(seconds: 2), () {
        if (mounted && _course == null) {
          print("DataService timeout - trying static method");
          final staticCourse = Course.getCourseById(widget.courseId);
          if (staticCourse != null) {
            setState(() {
              _course = staticCourse;
            });
          } else {
            // If static method also fails, create a mock course as last resort
            print("Static method failed - creating mock course");
            _createMockCourse();
          }
        }
      });
      
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF5B5FEF),
                ),
                SizedBox(height: 20),
                Text(
                  'Загрузка курса...',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF2D3142),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Вернуться назад',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF5B5FEF),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF5B5FEF)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Курс',
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border_rounded, color: Color(0xFF5B5FEF)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              _buildCourseHero(),
              SizedBox(height: 30),
              _buildCourseStats(),
              SizedBox(height: 30),
              _buildCourseDescription(),
              SizedBox(height: 30),
              _buildModulesList(),
              SizedBox(height: 30),
              _buildInstructorInfo(),
              SizedBox(height: 30),
              _buildStartButton(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildCourseHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF5B5FEF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _course!.emoji,
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _course!.technology,
                    style: GoogleFonts.montserrat(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _course!.title,
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF2D3142),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFF5B5FEF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _course!.level,
                          style: GoogleFonts.montserrat(
                            color: Color(0xFF5B5FEF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFF00C9B1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _course!.field,
                          style: GoogleFonts.montserrat(
                            color: Color(0xFF00C9B1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        _course!.rating.toString(),
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF2D3142),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(${_course!.reviewsCount} отзывов)',
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '${(_completionPercentage * 100).toInt()}% завершено',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF2D3142),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CircularPercentIndicator(
                    radius: 35,
                    lineWidth: 8,
                    percent: _completionPercentage,
                    center: Text(
                      '${(_completionPercentage * 100).toInt()}%',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF2D3142),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    progressColor: Color(0xFF5B5FEF),
                    backgroundColor: Color(0xFF5B5FEF).withOpacity(0.1),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildCourseStats() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Модули', _course!.modules.length.toString()),
          _buildStatItem('Уроки', _course!.totalLessonsCount.toString()),
          _buildStatItem('Задания', _course!.totalTasksCount.toString()),
          _buildStatItem('Часы', _course!.estimatedHours.toString()),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCourseDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'О курсе',
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Text(
          _course!.description,
          style: GoogleFonts.montserrat(
            color: Colors.grey[700],
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
  
  Widget _buildModulesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Модули курса',
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _course!.modules.length,
          itemBuilder: (context, index) {
            final module = _course!.modules[index];
            return _buildModuleTile(module, index);
          },
        ),
      ],
    );
  }
  
  Widget _buildModuleTile(Module module, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: ExpansionTile(
        title: Text(
          module.title,
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${module.completedLessonsCount}/${module.totalLessonsCount} уроков',
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142).withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFF5B5FEF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: GoogleFonts.montserrat(
                color: Color(0xFF5B5FEF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_down,
          color: Color(0xFF2D3142),
        ),
        children: module.lessons.map((lesson) => _buildLessonTile(lesson)).toList(),
      ),
    );
  }
  
  Widget _buildLessonTile(Lesson lesson) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: _getLessonTypeColor(lesson.type).withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Icon(
            _getLessonTypeIcon(lesson.type),
            color: _getLessonTypeColor(lesson.type),
            size: 16,
          ),
        ),
      ),
      title: Text(
        lesson.title,
        style: GoogleFonts.montserrat(
          color: Color(0xFF2D3142),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        '${lesson.duration} мин',
        style: GoogleFonts.montserrat(
          color: Color(0xFF2D3142).withOpacity(0.6),
          fontSize: 12,
        ),
      ),
      trailing: Icon(
        lesson.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: lesson.isCompleted ? Color(0xFF5B5FEF) : Colors.grey,
        size: 20,
      ),
      onTap: () {
        Get.to(() => LessonScreen(lesson: lesson));
      },
    );
  }
  
  Color _getLessonTypeColor(LessonType type) {
    switch (type) {
      case LessonType.theory:
        return Color(0xFF5B5FEF);
      case LessonType.task:
        return Color(0xFF00C853);
      case LessonType.project:
        return Color(0xFFFF6D00);
      case LessonType.quiz:
        return Color(0xFFD50000);
    }
  }
  
  IconData _getLessonTypeIcon(LessonType type) {
    switch (type) {
      case LessonType.theory:
        return Icons.menu_book;
      case LessonType.task:
        return Icons.assignment;
      case LessonType.project:
        return Icons.code;
      case LessonType.quiz:
        return Icons.quiz;
    }
  }
  
  Widget _buildInstructorInfo() {
    final instructor = _course!.instructor;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Инструктор',
          style: GoogleFonts.montserrat(
            color: Color(0xFF2D3142),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(16),
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
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF5B5FEF).withOpacity(0.2),
                child: Text(
                  instructor.avatarText,
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF5B5FEF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instructor.name,
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF2D3142),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      instructor.position,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${instructor.rating}',
                          style: GoogleFonts.montserrat(
                            color: Color(0xFF2D3142),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${instructor.studentsCount} студентов',
                          style: GoogleFonts.montserrat(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildStartButton() {
    return GestureDetector(
      onTap: () {
        // If course has modules and lessons, use the first task in the first module
        String? firstTaskId;
        if (_course!.modules.isNotEmpty) {
          for (final lesson in _course!.modules[0].lessons) {
            if (lesson.type == LessonType.task && lesson.taskId != null) {
              firstTaskId = lesson.taskId;
              break;
            }
          }
        }
        
        Get.to(() => TasksListScreen(
          track: _course!.technology, 
          courseId: _course!.id,
          taskId: firstTaskId,
        ));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5B5FEF), Color(0xFF7367F0)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF5B5FEF).withOpacity(0.3),
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Начать обучение',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Create a mock course as a fallback when all other methods fail
  void _createMockCourse() {
    if (!mounted) return;
    
    print("Creating mock course with ID: ${widget.courseId}");
    
    // For Junior Frontend course
    if (widget.courseId == "junior-frontend") {
      setState(() {
        _course = Course(
          id: "junior-frontend",
          title: "Junior Frontend (React)",
          description: "Курс по фронтенд-разработке с использованием React. Идеально подходит для начинающих разработчиков.",
          level: "Junior",
          technology: "React",
          field: "Frontend",
          rating: 4.7,
          reviewsCount: 128,
          emoji: "⚛️",
          estimatedHours: 24,
          totalTasksCount: 15,
          totalLessonsCount: 24,
          modules: [
            Module(
              id: "module-1",
              title: "Введение в JavaScript",
              description: "Основы JavaScript для начинающих",
              lessons: [
                Lesson(
                  id: "lesson-1-1",
                  title: "Основы JavaScript",
                  type: LessonType.theory,
                  duration: 30,
                  content: "Введение в JavaScript: история, особенности и применение языка.",
                ),
                Lesson(
                  id: "lesson-1-2",
                  title: "Переменные и типы данных",
                  type: LessonType.theory,
                  duration: 45,
                  content: "Изучение переменных и различных типов данных в JavaScript.",
                ),
                Lesson(
                  id: "lesson-1-3",
                  title: "Операторы и выражения",
                  type: LessonType.task,
                  duration: 60,
                  taskId: "task1",
                  content: "Практическое задание по работе с операторами и выражениями.",
                ),
              ],
            ),
            Module(
              id: "module-2",
              title: "Функции и объекты",
              description: "Работа с функциями и объектами в JavaScript",
              lessons: [
                Lesson(
                  id: "lesson-2-1",
                  title: "Функции в JavaScript",
                  type: LessonType.theory,
                  duration: 30,
                  content: "Изучение функций и их применения в JavaScript.",
                ),
                Lesson(
                  id: "lesson-2-2",
                  title: "Объекты и массивы",
                  type: LessonType.theory,
                  duration: 45,
                  content: "Работа с объектами и массивами в JavaScript.",
                ),
                Lesson(
                  id: "lesson-2-3",
                  title: "Практика с объектами",
                  type: LessonType.task,
                  duration: 60,
                  taskId: "task2",
                  content: "Практическое задание по работе с объектами.",
                ),
              ],
            ),
            Module(
              id: "module-3",
              title: "Основы React",
              description: "Введение в React и его основные концепции",
              lessons: [
                Lesson(
                  id: "lesson-3-1",
                  title: "Знакомство с React",
                  type: LessonType.theory,
                  duration: 30,
                  content: "Введение в React: история, особенности и преимущества.",
                ),
                Lesson(
                  id: "lesson-3-2",
                  title: "Компоненты в React",
                  type: LessonType.theory,
                  duration: 45,
                  content: "Изучение компонентов и их типов в React.",
                ),
                Lesson(
                  id: "lesson-3-3",
                  title: "Создание первого компонента",
                  type: LessonType.task,
                  duration: 60,
                  taskId: "task3",
                  content: "Практическое задание по созданию компонентов в React.",
                ),
              ],
            ),
          ],
          instructor: Instructor(
            id: "instructor1",
            name: "Александр Иванов",
            title: "Senior Frontend Developer",
            avatarInitials: "АИ",
          ),
        );
        _completionPercentage = 0.35; // Set some initial progress
      });
    } 
    // For Junior Backend Django course
    else if (widget.courseId == "junior-backend-django") {
      setState(() {
        _course = Course(
          id: "junior-backend-django",
          title: "Junior Backend (Django)",
          description: "Полный курс по бэкенд-разработке с использованием Django. Изучите основы веб-разработки на стороне сервера.",
          level: "Junior",
          technology: "Django",
          field: "Backend",
          rating: 4.5,
          reviewsCount: 94,
          emoji: "🐍",
          estimatedHours: 28,
          totalTasksCount: 18,
          totalLessonsCount: 26,
          modules: [
            Module(
              id: "module-1",
              title: "Введение в Python",
              description: "Основы Python для веб-разработки",
              lessons: [
                Lesson(
                  id: "lesson-1-1",
                  title: "Основы Python",
                  type: LessonType.theory,
                  duration: 30,
                  content: "Введение в Python: синтаксис и основные концепции.",
                ),
                Lesson(
                  id: "lesson-1-2",
                  title: "Работа с данными",
                  type: LessonType.theory,
                  duration: 45,
                  content: "Работа с различными типами данных в Python.",
                ),
                Lesson(
                  id: "lesson-1-3",
                  title: "Структуры данных Python",
                  type: LessonType.task,
                  duration: 60,
                  taskId: "task4",
                  content: "Практическое задание по работе со структурами данных.",
                ),
              ],
            ),
            Module(
              id: "module-2",
              title: "Основы Django",
              description: "Введение в Django Framework",
              lessons: [
                Lesson(
                  id: "lesson-2-1",
                  title: "Введение в Django",
                  type: LessonType.theory,
                  duration: 30,
                  content: "Знакомство с Django: архитектура и основные компоненты.",
                ),
                Lesson(
                  id: "lesson-2-2",
                  title: "Модели и миграции",
                  type: LessonType.theory,
                  duration: 45,
                  content: "Работа с моделями и миграциями в Django.",
                ),
                Lesson(
                  id: "lesson-2-3",
                  title: "Создание первого проекта",
                  type: LessonType.task,
                  duration: 60,
                  taskId: "task5",
                  content: "Практическое задание по созданию Django проекта.",
                ),
              ],
            ),
            Module(
              id: "module-3",
              title: "Django Views и Templates",
              description: "Работа с представлениями и шаблонами",
              lessons: [
                Lesson(
                  id: "lesson-3-1",
                  title: "Маршрутизация в Django",
                  type: LessonType.theory,
                  duration: 30,
                  content: "Изучение системы маршрутизации в Django.",
                ),
                Lesson(
                  id: "lesson-3-2",
                  title: "Шаблоны и представления",
                  type: LessonType.theory,
                  duration: 45,
                  content: "Работа с шаблонами и представлениями в Django.",
                ),
                Lesson(
                  id: "lesson-3-3",
                  title: "Разработка веб-страницы",
                  type: LessonType.task,
                  duration: 60,
                  taskId: "task6",
                  content: "Практическое задание по созданию веб-страницы.",
                ),
              ],
            ),
          ],
          instructor: Instructor(
            id: "instructor2",
            name: "Мария Петрова",
            title: "Django Developer",
            avatarInitials: "МП",
          ),
        );
        _completionPercentage = 0.2; // Set some initial progress
      });
    } else {
      // Generic fallback course
      setState(() {
        _course = Course(
          id: widget.courseId,
          title: "Программирование",
          description: "Курс по программированию для начинающих разработчиков.",
          level: "Junior",
          technology: "Programming",
          field: "Development",
          rating: 4.5,
          reviewsCount: 100,
          emoji: "💻",
          estimatedHours: 20,
          totalTasksCount: 10,
          totalLessonsCount: 20,
          modules: [
            Module(
              id: "module-1",
              title: "Основы программирования",
              description: "Базовые концепции программирования",
              lessons: [
                Lesson(
                  id: "lesson-1-1",
                  title: "Введение в программирование",
                  type: LessonType.theory,
                  duration: 30,
                  content: "Основные концепции и принципы программирования.",
                ),
                Lesson(
                  id: "lesson-1-2",
                  title: "Основные концепции",
                  type: LessonType.theory,
                  duration: 45,
                  content: "Изучение основных концепций программирования.",
                ),
                Lesson(
                  id: "lesson-1-3",
                  title: "Практическое задание",
                  type: LessonType.task,
                  duration: 60,
                  taskId: "task-generic",
                  content: "Практическое задание по основам программирования.",
                ),
              ],
            ),
          ],
          instructor: Instructor(
            id: "instructor-default",
            name: "Иван Преподаватель",
            title: "Senior Developer",
            avatarInitials: "ИП",
          ),
        );
        _completionPercentage = 0.1; // Set some initial progress
      });
    }
  }

  // Method to mark a task as completed and update progress
  void markTaskCompleted(String taskId) {
    if (_course == null) return;
    
    // Update progress percentage
    setState(() {
      // Increase progress by a small amount (would be more precise in a real app)
      _completionPercentage = (_completionPercentage + 0.05).clamp(0.0, 1.0);
      
      // Update user progress in DataService
      if (DataService.to != null) {
        try {
          final courseProgress = DataService.to.currentUser.coursesProgress[_course!.id];
          if (courseProgress != null) {
            final updatedProgress = courseProgress.addCompletedTask(taskId);
            DataService.to.updateCourseProgress(_course!.id, updatedProgress);
          }
        } catch (e) {
          print("Error updating progress: $e");
        }
      }
    });
  }
} 