import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class CalculatorProjectScreen extends StatefulWidget {
  final String courseId;
  final String track;

  const CalculatorProjectScreen({
    Key? key,
    required this.courseId,
    required this.track,
  }) : super(key: key);

  @override
  _CalculatorProjectScreenState createState() => _CalculatorProjectScreenState();
}

class _CalculatorProjectScreenState extends State<CalculatorProjectScreen>
    with TickerProviderStateMixin {
  int currentStep = 0;
  bool isProjectCompleted = false;
  Map<int, bool> completedSteps = {};
  
  late TabController _tabController;
  
  // Контроллеры для редакторов кода
  final TextEditingController _htmlController = TextEditingController();
  final TextEditingController _cssController = TextEditingController();
  final TextEditingController _jsController = TextEditingController();

  // Шаги проекта
  final List<Map<String, dynamic>> projectSteps = [
    {
      "title": "Создание HTML структуры",
      "description": "Создайте базовую HTML структуру для калькулятора",
      "instructions": [
        "Создайте контейнер для калькулятора",
        "Добавьте дисплей для отображения чисел",
        "Создайте кнопки для цифр (0-9)",
        "Добавьте кнопки операций (+, -, *, /)",
        "Добавьте кнопки = и C (очистить)"
      ],
      "startCode": '''<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Калькулятор</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- Ваш код здесь -->
    
    <script src="script.js"></script>
</body>
</html>''',
      "solution": '''<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Калькулятор</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="calculator">
        <div class="display">
            <input type="text" id="result" readonly>
        </div>
        <div class="buttons">
            <button onclick="clearDisplay()">C</button>
            <button onclick="deleteLast()">⌫</button>
            <button onclick="appendToDisplay('/')">/</button>
            <button onclick="appendToDisplay('*')">*</button>
            
            <button onclick="appendToDisplay('7')">7</button>
            <button onclick="appendToDisplay('8')">8</button>
            <button onclick="appendToDisplay('9')">9</button>
            <button onclick="appendToDisplay('-')">-</button>
            
            <button onclick="appendToDisplay('4')">4</button>
            <button onclick="appendToDisplay('5')">5</button>
            <button onclick="appendToDisplay('6')">6</button>
            <button onclick="appendToDisplay('+')">+</button>
            
            <button onclick="appendToDisplay('1')">1</button>
            <button onclick="appendToDisplay('2')">2</button>
            <button onclick="appendToDisplay('3')">3</button>
            <button onclick="calculate()" class="equals" rowspan="2">=</button>
            
            <button onclick="appendToDisplay('0')" class="zero">0</button>
            <button onclick="appendToDisplay('.')">.</button>
        </div>
    </div>
    
    <script src="script.js"></script>
</body>
</html>''',
      "checkPoints": [
        "Есть контейнер с классом 'calculator'",
        "Есть дисплей с input полем",
        "Есть кнопки для всех цифр 0-9",
        "Есть кнопки операций +, -, *, /",
        "Есть кнопка равно (=) и очистить (C)"
      ]
    },
    {
      "title": "Стилизация CSS",
      "description": "Создайте красивый дизайн для калькулятора",
      "instructions": [
        "Стилизуйте контейнер калькулятора",
        "Оформите дисплей",
        "Создайте сетку кнопок",
        "Добавьте hover эффекты",
        "Сделайте дизайн адаптивным"
      ],
      "startCode": '''/* Ваши стили здесь */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f0f0f0;
}''',
      "solution": '''body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 20px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.calculator {
    background: #2c3e50;
    border-radius: 20px;
    padding: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    max-width: 300px;
    width: 100%;
}

.display {
    margin-bottom: 20px;
}

.display input {
    width: 100%;
    height: 60px;
    font-size: 24px;
    text-align: right;
    border: none;
    background: #34495e;
    color: white;
    border-radius: 10px;
    padding: 0 15px;
    box-sizing: border-box;
}

.buttons {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
}

button {
    height: 60px;
    border: none;
    border-radius: 10px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
    background: #3498db;
    color: white;
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}

button:active {
    transform: translateY(0);
}

.equals {
    background: #e74c3c;
    grid-row: span 2;
}

.zero {
    grid-column: span 2;
}

button:nth-child(4n) {
    background: #f39c12;
}

button:first-child,
button:nth-child(2) {
    background: #95a5a6;
}''',
      "checkPoints": [
        "Калькулятор имеет современный дизайн",
        "Кнопки организованы в сетку",
        "Есть hover эффекты",
        "Дисплей стилизован",
        "Используются подходящие цвета"
      ]
    },
    {
      "title": "JavaScript функциональность",
      "description": "Добавьте логику работы калькулятора",
      "instructions": [
        "Создайте функцию для добавления символов на дисплей",
        "Реализуйте функцию очистки дисплея",
        "Добавьте функцию удаления последнего символа",
        "Создайте функцию вычисления результата",
        "Добавьте обработку ошибок"
      ],
      "startCode": '''// Ваш JavaScript код здесь
let display = document.getElementById('result');

function appendToDisplay(value) {
    // Ваш код
}

function clearDisplay() {
    // Ваш код
}

function calculate() {
    // Ваш код
}''',
      "solution": '''let display = document.getElementById('result');
let currentInput = '';
let operator = '';
let previousInput = '';

function appendToDisplay(value) {
    if (['+', '-', '*', '/'].includes(value)) {
        if (currentInput === '') return;
        if (previousInput !== '' && operator !== '') {
            calculate();
        }
        operator = value;
        previousInput = currentInput;
        currentInput = '';
        display.value = previousInput + ' ' + operator + ' ';
    } else {
        currentInput += value;
        if (operator === '') {
            display.value = currentInput;
        } else {
            display.value = previousInput + ' ' + operator + ' ' + currentInput;
        }
    }
}

function clearDisplay() {
    display.value = '';
    currentInput = '';
    operator = '';
    previousInput = '';
}

function deleteLast() {
    if (currentInput !== '') {
        currentInput = currentInput.slice(0, -1);
        if (operator === '') {
            display.value = currentInput;
        } else {
            display.value = previousInput + ' ' + operator + ' ' + currentInput;
        }
    }
}

function calculate() {
    if (previousInput === '' || currentInput === '' || operator === '') {
        return;
    }
    
    let result;
    const prev = parseFloat(previousInput);
    const current = parseFloat(currentInput);
    
    if (isNaN(prev) || isNaN(current)) {
        display.value = 'Ошибка';
        return;
    }
    
    switch (operator) {
        case '+':
            result = prev + current;
            break;
        case '-':
            result = prev - current;
            break;
        case '*':
            result = prev * current;
            break;
        case '/':
            if (current === 0) {
                display.value = 'Ошибка: деление на ноль';
                return;
            }
            result = prev / current;
            break;
        default:
            return;
    }
    
    display.value = result;
    currentInput = result.toString();
    operator = '';
    previousInput = '';
}

// Поддержка клавиатуры
document.addEventListener('keydown', function(event) {
    const key = event.key;
    
    if (key >= '0' && key <= '9' || key === '.') {
        appendToDisplay(key);
    } else if (['+', '-', '*', '/'].includes(key)) {
        appendToDisplay(key);
    } else if (key === 'Enter' || key === '=') {
        calculate();
    } else if (key === 'Escape' || key === 'c' || key === 'C') {
        clearDisplay();
    } else if (key === 'Backspace') {
        deleteLast();
    }
});''',
      "checkPoints": [
        "Функция appendToDisplay работает корректно",
        "Функция clearDisplay очищает дисплей",
        "Функция calculate выполняет вычисления",
        "Обрабатываются ошибки (деление на ноль)",
        "Поддерживается ввод с клавиатуры"
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Инициализируем начальный код
    _updateCodeEditors();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _htmlController.dispose();
    _cssController.dispose();
    _jsController.dispose();
    super.dispose();
  }

  void _updateCodeEditors() {
    if (currentStep < projectSteps.length) {
      final step = projectSteps[currentStep];
      if (step['startCode'] != null) {
        switch (currentStep) {
          case 0:
            _htmlController.text = step['startCode'];
            break;
          case 1:
            _cssController.text = step['startCode'];
            break;
          case 2:
            _jsController.text = step['startCode'];
            break;
        }
      }
    }
  }

  void _checkStep() {
    // Простая проверка наличия ключевых элементов в коде
    bool isStepCompleted = _validateStep();
    
    if (isStepCompleted) {
      setState(() {
        completedSteps[currentStep] = true;
      });
      
      _showStepCompletionDialog();
    } else {
      final step = projectSteps[currentStep];
      final checkPoints = step['checkPoints'] as List<String>;
      _showValidationDialog(checkPoints);
    }
  }

  bool _validateStep() {
    final step = projectSteps[currentStep];
    final checkPoints = step['checkPoints'] as List<String>;
    
    switch (currentStep) {
      case 0: // HTML
        final html = _htmlController.text.toLowerCase();
        return html.contains('calculator') &&
               html.contains('input') &&
               html.contains('button') &&
               html.contains('onclick');
      case 1: // CSS
        final css = _cssController.text.toLowerCase();
        return css.contains('.calculator') &&
               css.contains('display') &&
               css.contains('grid') &&
               css.contains('button');
      case 2: // JavaScript
        final js = _jsController.text.toLowerCase();
        return js.contains('appendtodisplay') &&
               js.contains('cleardisplay') &&
               js.contains('calculate') &&
               js.contains('function');
      default:
        return false;
    }
  }

  void _showStepCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Шаг завершен! 🎉',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Отличная работа! Вы успешно завершили "${projectSteps[currentStep]['title']}"',
                textAlign: TextAlign.center,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showSolution();
                      },
                      child: Text(
                        'Показать решение',
                        style: GoogleFonts.firaCode(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _nextStep();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        currentStep < projectSteps.length - 1 ? 'Далее' : 'Завершить',
                        style: GoogleFonts.firaCode(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showValidationDialog(List<String> checkPoints) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.info,
                  color: AppColors.warning,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Проверьте код',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Убедитесь, что ваш код содержит:',
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              ...checkPoints.map((point) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        point,
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showSolution();
                      },
                      child: Text(
                        'Показать решение',
                        style: GoogleFonts.firaCode(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Попробовать еще',
                        style: GoogleFonts.firaCode(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSolution() {
    final step = projectSteps[currentStep];
    final solution = step['solution'] as String;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Решение',
            style: GoogleFonts.firaCode(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  solution,
                  style: GoogleFonts.firaCode(
                    fontSize: 12,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Закрыть',
                style: GoogleFonts.firaCode(
                  color: AppColors.primary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _applySolution(solution);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Применить',
                style: GoogleFonts.firaCode(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _applySolution(String solution) {
    setState(() {
      switch (currentStep) {
        case 0:
          _htmlController.text = solution;
          break;
        case 1:
          _cssController.text = solution;
          break;
        case 2:
          _jsController.text = solution;
          break;
      }
    });
  }

  void _nextStep() {
    if (currentStep < projectSteps.length - 1) {
      setState(() {
        currentStep++;
        _updateCodeEditors();
      });
    } else {
      _completeProject();
    }
  }

  void _completeProject() {
    setState(() {
      isProjectCompleted = true;
    });
    
    _showProjectCompletionDialog();
  }

  void _showProjectCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.emoji_events,
                  color: AppColors.success,
                  size: 60,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Проект завершен! 🏆',
                style: GoogleFonts.firaCode(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Поздравляем! Вы успешно создали калькулятор на JavaScript!',
                textAlign: TextAlign.center,
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Награды:',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 24),
                            Text(
                              '50 XP',
                              style: GoogleFonts.firaCode(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.emoji_events, color: AppColors.success, size: 24),
                            Text(
                              'Сертификат',
                              style: GoogleFonts.firaCode(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.code, color: AppColors.primary, size: 24),
                            Text(
                              'Проект',
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                  'Завершить модуль',
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStepData = projectSteps[currentStep];
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Проект: Калькулятор на JavaScript',
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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'HTML'),
            Tab(text: 'CSS'),
            Tab(text: 'JavaScript'),
          ],
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Прогресс и информация о шаге
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Прогресс бар
                Row(
                  children: [
                    Text(
                      'Шаг ${currentStep + 1} из ${projectSteps.length}',
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${((currentStep + 1) / projectSteps.length * 100).round()}%',
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (currentStep + 1) / projectSteps.length,
                  backgroundColor: AppColors.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 8,
                ),
                const SizedBox(height: 20),
                
                // Информация о текущем шаге
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentStepData['title'],
                        style: GoogleFonts.firaCode(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentStepData['description'],
                        style: GoogleFonts.firaCode(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Задачи:',
                        style: GoogleFonts.firaCode(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...currentStepData['instructions'].map<Widget>((instruction) => 
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: AppColors.primary,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  instruction,
                                  style: GoogleFonts.firaCode(
                                    fontSize: 12,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Редактор кода
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCodeEditor(_htmlController, 'HTML'),
                _buildCodeEditor(_cssController, 'CSS'),
                _buildCodeEditor(_jsController, 'JavaScript'),
              ],
            ),
          ),
          
          // Кнопки действий
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showSolution(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Показать решение',
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _checkStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Проверить код',
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

  Widget _buildCodeEditor(TextEditingController controller, String language) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.code,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  language,
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              expands: true,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: Colors.white,
                height: 1.4,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                hintText: 'Введите ваш код здесь...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 