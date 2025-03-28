import 'package:devup/Screens/Learning/task_detail_screen.dart';
import 'package:devup/Screens/Learning/tasks_list_screen.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/Learning/theory_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskPathWidget extends StatelessWidget {
  final String track;
  final List<Map<String, dynamic>> tasks;
  final String category;

  const TaskPathWidget({
    Key? key,
    required this.track,
    required this.tasks,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
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

    final List<Widget> pathItems = [];
    int taskCounter = 0;

    pathItems.add(
      TheoryBlock(
        title:
            "Введение в ${track.contains("Frontend") ? "Frontend" : track.contains("Django") ? "Django" : "Spring"}",
        content:
            "Изучите основные концепции и принципы работы с ${track.contains("Frontend") ? "React и современным фронтендом" : track.contains("Django") ? "Django и Python" : "Spring и Java"}.",
        bulletPoints: [
          "Основные понятия и терминология",
          "Архитектура и принципы работы",
          "Лучшие практики и паттерны"
        ],
      ),
    );

    for (int i = 0; i < tasks.length; i++) {
      pathItems
          .add(_buildTaskNode(context, tasks[i], i, i == tasks.length - 1));
      taskCounter++;

      if (taskCounter % 3 == 0 && i < tasks.length - 1) {
        String theoryTitle = "";
        String theoryContent = "";
        String? codeExample;
        List<String> bulletPoints = [];

        if (track.contains("Frontend")) {
          if (taskCounter == 3) {
            theoryTitle = "Основы React компонентов";
            theoryContent =
                "Компоненты - это строительные блоки React-приложений. Они позволяют разделить UI на независимые, переиспользуемые части.";
            codeExample =
                "function Welcome(props) {\n  return <h1>Привет, {props.name}</h1>;\n}";
            bulletPoints = [
              "Функциональные компоненты",
              "Классовые компоненты",
              "Жизненный цикл компонентов"
            ];
          } else if (taskCounter == 6) {
            theoryTitle = "Хуки в React";
            theoryContent =
                "Хуки позволяют использовать состояние и другие возможности React без написания классов.";
            codeExample =
                "function Counter() {\n  const [count, setCount] = useState(0);\n  return (\n    <div>\n      <p>Вы кликнули {count} раз</p>\n      <button onClick={() => setCount(count + 1)}>\n        Нажми на меня\n      </button>\n    </div>\n  );\n}";
            bulletPoints = [
              "useState",
              "useEffect",
              "useContext",
              "useReducer"
            ];
          } else {
            theoryTitle = "Продвинутые концепции React";
            theoryContent =
                "Изучите продвинутые техники и паттерны для создания сложных React-приложений.";
            bulletPoints = [
              "Контекст и управление состоянием",
              "Оптимизация производительности",
              "Работа с формами"
            ];
          }
        } else if (track.contains("Django")) {
          if (taskCounter == 3) {
            theoryTitle = "Модели в Django";
            theoryContent =
                "Модели определяют структуру данных вашего приложения и предоставляют методы для работы с базой данных.";
            codeExample =
                "class Article(models.Model):\n    title = models.CharField(max_length=200)\n    content = models.TextField()\n    pub_date = models.DateTimeField('date published')\n    \n    def __str__(self):\n        return self.title";
            bulletPoints = [
              "Определение моделей",
              "Миграции",
              "Запросы к базе данных"
            ];
          } else if (taskCounter == 6) {
            theoryTitle = "Представления в Django";
            theoryContent =
                "Представления обрабатывают HTTP-запросы и возвращают HTTP-ответы. Они связывают модели и шаблоны.";
            codeExample =
                "def article_detail(request, article_id):\n    article = get_object_or_404(Article, pk=article_id)\n    return render(request, 'articles/detail.html', {'article': article})";
            bulletPoints = [
              "Функциональные представления",
              "Классовые представления",
              "Обработка форм"
            ];
          } else {
            theoryTitle = "Шаблоны и формы в Django";
            theoryContent =
                "Шаблоны определяют структуру HTML-страниц, а формы обрабатывают пользовательский ввод.";
            bulletPoints = [
              "Язык шаблонов Django",
              "Наследование шаблонов",
              "Создание и валидация форм"
            ];
          }
        } else {
          if (taskCounter == 3) {
            theoryTitle = "Spring Boot основы";
            theoryContent =
                "Spring Boot упрощает создание автономных, production-ready приложений на базе Spring.";
            codeExample =
                "@RestController\npublic class HelloController {\n    @GetMapping(\"/hello\")\n    public String hello() {\n        return \"Hello, World!\";\n    }\n}";
            bulletPoints = [
              "Автоконфигурация",
              "Стартеры",
              "Внедрение зависимостей"
            ];
          } else if (taskCounter == 6) {
            theoryTitle = "Spring Data JPA";
            theoryContent =
                "Spring Data JPA упрощает работу с базами данных в приложениях Spring.";
            codeExample =
                "@Entity\npublic class User {\n    @Id\n    @GeneratedValue(strategy = GenerationType.AUTO)\n    private Long id;\n    private String name;\n    private String email;\n    \n    // Геттеры и сеттеры\n}";
            bulletPoints = ["Репозитории", "Запросы", "Транзакции"];
          } else {
            theoryTitle = "Spring Security";
            theoryContent =
                "Spring Security обеспечивает аутентификацию и авторизацию в приложениях Spring.";
            bulletPoints = ["Аутентификация", "Авторизация", "OAuth2"];
          }
        }

        pathItems.add(
          TheoryBlock(
            title: theoryTitle,
            content: theoryContent,
            codeExample: codeExample,
            bulletPoints: bulletPoints,
          ),
        );
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: pathItems,
        ),
      ),
    );
  }

  Widget _buildTaskNode(
      BuildContext context, Map<String, dynamic> task, int index, bool isLast) {
    final bool isCompleted = task["completed"] ?? false;
    final bool isLocked = task["locked"] ?? false;

    Color nodeColor;
    if (task["difficulty"] == "Легкий") {
      nodeColor = AppColors.success;
    } else if (task["difficulty"] == "Средний") {
      nodeColor = AppColors.warning;
    } else {
      nodeColor = AppColors.error;
    }

    if (isCompleted) {
      nodeColor = AppColors.success;
    }

    if (isLocked) {
      nodeColor = AppColors.textLight;
    }

    return Column(
      children: [
        GestureDetector(
          onTap: isLocked
              ? null
              : () {
                  final TasksListScreen? tasksListScreen =
                      context.findAncestorWidgetOfExactType<TasksListScreen>();

                  Get.to(() => TaskDetailScreen(
                        task: task,
                        courseId: tasksListScreen?.courseId,
                        track: tasksListScreen?.track ?? task["track"],
                      ));
                },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isLocked ? AppColors.surface : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: nodeColor,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: nodeColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(
                            Icons.check,
                            color: AppColors.success,
                            size: 30,
                          )
                        : isLocked
                            ? Icon(
                                Icons.lock,
                                color: AppColors.textLight,
                                size: 24,
                              )
                            : Text(
                                "${index + 1}",
                                style: GoogleFonts.firaCode(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: nodeColor,
                                ),
                              ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isLocked
                          ? AppColors.surface.withOpacity(0.7)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isLocked ? AppColors.textLight : nodeColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: nodeColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                task["difficulty"],
                                style: GoogleFonts.firaCode(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: nodeColor,
                                ),
                              ),
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
                                  "${task["energyCost"]}",
                                  style: GoogleFonts.firaCode(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isLocked
                                        ? AppColors.textLight
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          task["title"],
                          style: GoogleFonts.firaCode(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isLocked
                                ? AppColors.textLight
                                : AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          task["type"],
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            color: isLocked
                                ? AppColors.textLight
                                : AppColors.textSecondary,
                          ),
                        ),
                        if (!isLocked) SizedBox(height: 10),
                        if (!isLocked)
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.xp,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${task["xpReward"]} XP",
                                style: GoogleFonts.firaCode(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.xp,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Container(
            margin: EdgeInsets.only(left: 30),
            width: 3,
            height: 40,
            color: isCompleted ? AppColors.success : AppColors.textLight,
          ),
      ],
    );
  }
}
