import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class ObjectsPracticeEasy extends StatefulWidget {
  const ObjectsPracticeEasy({Key? key}) : super(key: key);

  @override
  _ObjectsPracticeEasyState createState() => _ObjectsPracticeEasyState();
}

class _ObjectsPracticeEasyState extends State<ObjectsPracticeEasy> {
  int currentStep = 0;
  List<bool> completedSteps = [false, false, false];
  
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Создание объекта',
      'description': 'Создайте объект person с свойствами name, age и city',
      'hint': 'Используйте фигурные скобки {} для создания объекта',
      'solution': '''const person = {
  name: "Анна",
  age: 25,
  city: "Москва"
};''',
      'explanation': 'Объекты создаются с помощью фигурных скобок. Каждое свойство состоит из ключа и значения, разделенных двоеточием.'
    },
    {
      'title': 'Доступ к свойствам',
      'description': 'Получите значение свойства name из объекта person',
      'hint': 'Используйте точечную нотацию: объект.свойство',
      'solution': '''const personName = person.name;
console.log(personName); // "Анна"

// Или через квадратные скобки
const personName2 = person["name"];''',
      'explanation': 'К свойствам объекта можно обращаться двумя способами: через точку (person.name) или через квадратные скобки (person["name"]).'
    },
    {
      'title': 'Добавление метода',
      'description': 'Добавьте метод greet в объект person, который возвращает приветствие',
      'hint': 'Метод - это функция внутри объекта. Используйте this для обращения к свойствам объекта',
      'solution': '''person.greet = function() {
  return "Привет, меня зовут " + this.name;
};

// Или при создании объекта
const person = {
  name: "Анна",
  age: 25,
  city: "Москва",
  greet: function() {
    return "Привет, меня зовут " + this.name;
  }
};''',
      'explanation': 'Методы - это функции, принадлежащие объекту. Ключевое слово this ссылается на текущий объект.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Практика: Объекты (Легко)',
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
                    _buildTaskCard(),
                    const SizedBox(height: 20),
                    _buildHintCard(),
                    const SizedBox(height: 20),
                    if (completedSteps[currentStep]) _buildSolutionCard(),
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
              'Прогресс',
              style: GoogleFonts.firaCode(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${currentStep + 1}/${tasks.length}',
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (currentStep + 1) / tasks.length,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildTaskCard() {
    final task = tasks[currentStep];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
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
                  color: AppColors.primary,
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
                  task['title'],
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
            task['description'],
            style: GoogleFonts.firaCode(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintCard() {
    final task = tasks[currentStep];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.amber.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: Colors.amber[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Подсказка',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            task['hint'],
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: Colors.amber[800],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionCard() {
    final task = tasks[currentStep];
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
                Icons.check_circle,
                color: AppColors.success,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Решение',
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
            child: Text(
              task['solution'],
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: Colors.green[300],
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            task['explanation'],
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
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Показать решение',
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
                      if (currentStep < tasks.length - 1) {
                        setState(() {
                          currentStep++;
                        });
                      } else {
                        // Завершение практики
                        _showCompletionDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentStep < tasks.length - 1 
                          ? AppColors.primary 
                          : AppColors.success,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      currentStep < tasks.length - 1 ? 'Далее' : 'Завершить',
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
                Icons.celebration,
                color: AppColors.success,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Отлично!',
                style: GoogleFonts.firaCode(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          content: Text(
            'Вы успешно завершили легкую практику по объектам! Теперь вы знаете основы работы с объектами в JavaScript.',
            style: GoogleFonts.firaCode(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Продолжить',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
} 