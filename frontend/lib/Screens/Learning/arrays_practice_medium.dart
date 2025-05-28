import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/Services/progress_manager.dart';

class ArraysPracticeMedium extends StatefulWidget {
  const ArraysPracticeMedium({Key? key}) : super(key: key);

  @override
  _ArraysPracticeMediumState createState() => _ArraysPracticeMediumState();
}

class _ArraysPracticeMediumState extends State<ArraysPracticeMedium> {
  int currentStep = 0;
  List<bool> completedSteps = [false, false, false, false];
  
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Фильтрация массива',
      'description': 'Из массива чисел [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] получите только четные числа',
      'hint': 'Используйте метод filter() с условием n % 2 === 0',
      'solution': '''const numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
const evenNumbers = numbers.filter(n => n % 2 === 0);
console.log(evenNumbers); // [2, 4, 6, 8, 10]''',
      'explanation': 'Метод filter() создает новый массив с элементами, которые проходят проверку в функции-колбэке.'
    },
    {
      'title': 'Преобразование массива',
      'description': 'Преобразуйте массив строк ["hello", "world", "javascript"] в массив их длин',
      'hint': 'Используйте метод map() и свойство length',
      'solution': '''const words = ["hello", "world", "javascript"];
const lengths = words.map(word => word.length);
console.log(lengths); // [5, 5, 10]

// Или более подробно
const lengths2 = words.map(function(word) {
  return word.length;
});''',
      'explanation': 'Метод map() создает новый массив с результатами вызова функции для каждого элемента.'
    },
    {
      'title': 'Поиск в массиве',
      'description': 'В массиве объектов найдите пользователя с именем "Анна"',
      'hint': 'Используйте метод find() для поиска объекта по условию',
      'solution': '''const users = [
  { name: "Петр", age: 25 },
  { name: "Анна", age: 30 },
  { name: "Иван", age: 35 }
];

const anna = users.find(user => user.name === "Анна");
console.log(anna); // { name: "Анна", age: 30 }

// Если нужен индекс
const annaIndex = users.findIndex(user => user.name === "Анна");
console.log(annaIndex); // 1''',
      'explanation': 'Метод find() возвращает первый элемент, который удовлетворяет условию. findIndex() возвращает его индекс.'
    },
    {
      'title': 'Сведение массива',
      'description': 'Подсчитайте общую сумму всех чисел в массиве [10, 20, 30, 40, 50]',
      'hint': 'Используйте метод reduce() с аккумулятором',
      'solution': '''const numbers = [10, 20, 30, 40, 50];

// Краткая запись
const sum = numbers.reduce((acc, num) => acc + num, 0);
console.log(sum); // 150

// Подробная запись
const sum2 = numbers.reduce(function(accumulator, currentValue) {
  return accumulator + currentValue;
}, 0);

// Без начального значения (первый элемент станет аккумулятором)
const sum3 = numbers.reduce((acc, num) => acc + num);''',
      'explanation': 'Метод reduce() применяет функцию к аккумулятору и каждому элементу массива, сводя их к одному значению.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Практика: Массивы (Средне)',
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
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
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
          color: Colors.orange.withOpacity(0.3),
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
                  color: Colors.orange,
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
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline,
                color: Colors.blue[700],
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Подсказка',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            task['hint'],
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: Colors.blue[800],
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
                backgroundColor: Colors.orange,
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
                          ? Colors.orange 
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
    // Отмечаем практику как пройденную
    ProgressManager.completeTest('arrays_practice_medium', 50);
    
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
                Icons.star,
                color: Colors.orange,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Превосходно!',
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
                'Вы освоили методы массивов среднего уровня! Теперь вы можете эффективно работать с данными в JavaScript.',
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
                  color: Colors.orange.withOpacity(0.1),
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
                      '+50 XP',
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
                'Продолжить',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
} 