import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/Services/progress_manager.dart';

class TodoAppProject extends StatefulWidget {
  const TodoAppProject({Key? key}) : super(key: key);

  @override
  _TodoAppProjectState createState() => _TodoAppProjectState();
}

class _TodoAppProjectState extends State<TodoAppProject> {
  int currentStep = 0;
  List<bool> completedSteps = [false, false, false, false, false];
  
  final List<Map<String, dynamic>> steps = [
    {
      'title': 'Структура данных',
      'description': 'Создайте структуру для хранения задач с использованием объектов и массивов',
      'code': r'''// Структура одной задачи
const task = {
  id: 1,
  text: "Изучить JavaScript",
  completed: false,
  priority: "high", // high, medium, low
  createdAt: new Date(),
  category: "обучение"
};

// Массив всех задач
let todos = [
  {
    id: 1,
    text: "Изучить объекты",
    completed: true,
    priority: "high",
    createdAt: new Date("2024-01-01"),
    category: "обучение"
  },
  {
    id: 2,
    text: "Сделать покупки",
    completed: false,
    priority: "medium",
    createdAt: new Date("2024-01-02"),
    category: "дом"
  }
];''',
      'explanation': 'Каждая задача - это объект с уникальными свойствами. Все задачи хранятся в массиве для удобной обработки.'
    },
    {
      'title': 'Добавление задач',
      'description': 'Реализуйте функцию для добавления новых задач в список',
      'code': r'''// Функция для создания новой задачи
function createTask(text, priority = "medium", category = "общее") {
  return {
    id: Date.now(), // Простой способ генерации ID
    text: text,
    completed: false,
    priority: priority,
    createdAt: new Date(),
    category: category
  };
}

// Функция для добавления задачи
function addTask(text, priority, category) {
  const newTask = createTask(text, priority, category);
  todos.push(newTask);
  console.log(`Задача "${text}" добавлена!`);
  return newTask;
}

// Пример использования
addTask("Прочитать книгу", "low", "саморазвитие");
addTask("Встреча с командой", "high", "работа");''',
      'explanation': 'Функция createTask создает объект задачи с нужными свойствами. addTask добавляет новую задачу в массив todos.'
    },
    {
      'title': 'Фильтрация и поиск',
      'description': 'Создайте функции для фильтрации задач по различным критериям',
      'code': r'''// Получить все выполненные задачи
function getCompletedTasks() {
  return todos.filter(task => task.completed);
}

// Получить активные (невыполненные) задачи
function getActiveTasks() {
  return todos.filter(task => !task.completed);
}

// Фильтр по приоритету
function getTasksByPriority(priority) {
  return todos.filter(task => task.priority === priority);
}

// Фильтр по категории
function getTasksByCategory(category) {
  return todos.filter(task => task.category === category);
}

// Поиск задач по тексту
function searchTasks(searchText) {
  return todos.filter(task => 
    task.text.toLowerCase().includes(searchText.toLowerCase())
  );
}

// Комбинированный фильтр с деструктуризацией
function filterTasks({ completed, priority, category } = {}) {
  return todos.filter(task => {
    if (completed !== undefined && task.completed !== completed) return false;
    if (priority && task.priority !== priority) return false;
    if (category && task.category !== category) return false;
    return true;
  });
}''',
      'explanation': 'Используем метод filter() для создания новых массивов с отфильтрованными задачами. Деструктуризация в параметрах функции позволяет передавать объект с опциями.'
    },
    {
      'title': 'Управление состоянием',
      'description': 'Реализуйте функции для изменения состояния задач',
      'code': r'''// Переключить статус выполнения задачи
function toggleTask(id) {
  const task = todos.find(task => task.id === id);
  if (task) {
    task.completed = !task.completed;
    console.log(`Задача "${task.text}" ${task.completed ? 'выполнена' : 'не выполнена'}`);
  }
}

// Удалить задачу
function deleteTask(id) {
  const index = todos.findIndex(task => task.id === id);
  if (index !== -1) {
    const deletedTask = todos.splice(index, 1)[0];
    console.log(`Задача "${deletedTask.text}" удалена`);
    return deletedTask;
  }
}

// Редактировать задачу
function editTask(id, updates) {
  const task = todos.find(task => task.id === id);
  if (task) {
    // Используем spread оператор для обновления свойств
    Object.assign(task, updates);
    console.log(`Задача обновлена:`, task);
    return task;
  }
}

// Массовые операции
function markAllCompleted() {
  todos.forEach(task => task.completed = true);
}

function clearCompleted() {
  todos = todos.filter(task => !task.completed);
}''',
      'explanation': 'find() находит задачу по ID, splice() удаляет элемент из массива, Object.assign() обновляет свойства объекта.'
    },
    {
      'title': 'Статистика и аналитика',
      'description': 'Создайте функции для получения статистики по задачам',
      'code': r'''// Получить статистику по задачам
function getTaskStats() {
  const total = todos.length;
  const completed = todos.filter(task => task.completed).length;
  const active = total - completed;
  
  // Группировка по приоритетам
  const byPriority = todos.reduce((acc, task) => {
    acc[task.priority] = (acc[task.priority] || 0) + 1;
    return acc;
  }, {});
  
  // Группировка по категориям
  const byCategory = todos.reduce((acc, task) => {
    acc[task.category] = (acc[task.category] || 0) + 1;
    return acc;
  }, {});
  
  return {
    total,
    completed,
    active,
    completionRate: total > 0 ? Math.round((completed / total) * 100) : 0,
    byPriority,
    byCategory
  };
}

// Получить задачи, созданные сегодня
function getTodaysTasks() {
  const today = new Date().toDateString();
  return todos.filter(task => 
    task.createdAt.toDateString() === today
  );
}

// Сортировка задач
function sortTasks(sortBy = 'createdAt', order = 'desc') {
  return [...todos].sort((a, b) => {
    let aValue = a[sortBy];
    let bValue = b[sortBy];
    
    if (sortBy === 'createdAt') {
      aValue = new Date(aValue);
      bValue = new Date(bValue);
    }
    
    if (order === 'asc') {
      return aValue > bValue ? 1 : -1;
    } else {
      return aValue < bValue ? 1 : -1;
    }
  });
}

// Пример использования
console.log('Статистика:', getTaskStats());
console.log('Задачи по дате:', sortTasks('createdAt', 'desc'));''',
      'explanation': 'reduce() используется для группировки данных, spread оператор [...todos] создает копию массива для сортировки, не изменяя оригинал.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Проект: Todo App (Сложно)',
          style: GoogleFonts.firaCode(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Прогресс бар
            _buildProgressBar(),
            const SizedBox(height: 20),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStepCard(),
                    const SizedBox(height: 20),
                    if (completedSteps[currentStep]) _buildCodeCard(),
                  ],
                ),
              ),
            ),
            
            // Кнопки навигации
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Прогресс проекта',
              style: GoogleFonts.firaCode(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${currentStep + 1}/${steps.length}',
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (currentStep + 1) / steps.length,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ],
    );
  }

  Widget _buildStepCard() {
    final step = steps[currentStep];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 2,
        ),
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
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${currentStep + 1}',
                    style: GoogleFonts.firaCode(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  step['title'],
                  style: GoogleFonts.firaCode(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            step['description'],
            style: GoogleFonts.firaCode(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.red.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: Colors.red[700],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Этот шаг демонстрирует практическое применение объектов, массивов и их методов',
                    style: GoogleFonts.firaCode(
                      fontSize: 14,
                      color: Colors.red[800],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeCard() {
    final step = steps[currentStep];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.success.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.code,
                color: AppColors.success,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Реализация',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                step['code'],
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: Colors.green[300],
                  height: 1.4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            step['explanation'],
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Column(
      children: [
        if (!completedSteps[currentStep])
          Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  completedSteps[currentStep] = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Показать код',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        
        if (completedSteps[currentStep])
          Row(
            children: [
              if (currentStep > 0)
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentStep--;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Назад',
                        style: GoogleFonts.firaCode(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              
              Expanded(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(left: currentStep > 0 ? 8 : 0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentStep < steps.length - 1) {
                        setState(() {
                          currentStep++;
                        });
                      } else {
                        // Завершение проекта
                        _showCompletionDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentStep < steps.length - 1 
                          ? Colors.red 
                          : AppColors.success,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      currentStep < steps.length - 1 ? 'Далее' : 'Завершить проект',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        
        const SizedBox(height: 16),
      ],
    );
  }

  void _showCompletionDialog() {
    // Отмечаем проект как завершенный
    ProgressManager.completeTest('todo_app_project', 100);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            children: [
              Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Проект завершен!',
                style: GoogleFonts.firaCode(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Поздравляем! Вы создали полнофункциональное Todo приложение, используя объекты, массивы, деструктуризацию и современные методы JavaScript. Это серьезное достижение!',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '+100 XP',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Отлично!',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
} 