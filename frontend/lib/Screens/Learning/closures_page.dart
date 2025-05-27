import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class ClosuresPage extends StatelessWidget {
  const ClosuresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Замыкания и область видимости',
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Введение
                    _buildTheoryBlock(
                      'Замыкания — одна из самых мощных и важных концепций JavaScript. Они позволяют функциям "запоминать" переменные из внешней области видимости.',
                    ),
                    const SizedBox(height: 24),

                    // 1. Область видимости
                    _buildSectionTitle('1. Область видимости (Scope)', Icons.visibility),
                    const SizedBox(height: 12),
                    _buildSubsection('Типы областей видимости:', [
                      'Глобальная область видимости',
                      'Функциональная область видимости',
                      'Блочная область видимости (let, const)',
                      'Модульная область видимости',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Глобальная область видимости
var globalVar = "Я глобальная";

function testScope() {
  // Функциональная область видимости
  var functionVar = "Я в функции";
  
  if (true) {
    // Блочная область видимости
    let blockVar = "Я в блоке";
    const alsoBlockVar = "Я тоже в блоке";
    var functionScoped = "Я все еще в функции";
    
    console.log(globalVar);     // "Я глобальная"
    console.log(functionVar);   // "Я в функции"
    console.log(blockVar);      // "Я в блоке"
  }
  
  console.log(functionScoped);  // "Я все еще в функции"
  // console.log(blockVar);     // ReferenceError!
}

testScope();'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '⚡ Важно!',
                      'var имеет функциональную область видимости, let и const — блочную. Это ключевое различие!',
                      AppColors.warning,
                    ),
                    const SizedBox(height: 24),

                    // 2. Что такое замыкание
                    _buildSectionTitle('2. Что такое замыкание?', Icons.lock),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Замыкание — это функция, которая имеет доступ к переменным из внешней области видимости даже после того, как внешняя функция завершила выполнение.',
                    ),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Простое замыкание
function outerFunction(x) {
  // Внешняя переменная
  
  function innerFunction(y) {
    // Внутренняя функция имеет доступ к x
    return x + y;
  }
  
  return innerFunction;
}

const addFive = outerFunction(5);
console.log(addFive(3)); // 8

// outerFunction уже завершилась, но x = 5 все еще доступна!'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '🔥 Магия замыканий',
                      'Функция innerFunction "замкнула" переменную x из внешней области видимости и сохранила к ней доступ!',
                      AppColors.primary,
                    ),
                    const SizedBox(height: 24),

                    // 3. Практические примеры
                    _buildSectionTitle('3. Практические примеры', Icons.code),
                    const SizedBox(height: 12),
                    _buildSubsection('Счетчик с замыканием:', []),
                    const SizedBox(height: 8),
                    _buildCodeBlock('''// Создание приватного счетчика
function createCounter() {
  let count = 0; // Приватная переменная
  
  return {
    increment: function() {
      count++;
      return count;
    },
    decrement: function() {
      count--;
      return count;
    },
    getValue: function() {
      return count;
    }
  };
}

const counter = createCounter();
console.log(counter.increment()); // 1
console.log(counter.increment()); // 2
console.log(counter.getValue());  // 2
console.log(counter.decrement()); // 1

// count недоступна напрямую - это приватность!
console.log(counter.count); // undefined'''),
                    const SizedBox(height: 16),

                    _buildSubsection('Фабрика функций:', []),
                    const SizedBox(height: 8),
                    _buildCodeBlock('''// Создание специализированных функций
function createMultiplier(multiplier) {
  return function(number) {
    return number * multiplier;
  };
}

const double = createMultiplier(2);
const triple = createMultiplier(3);
const quadruple = createMultiplier(4);

console.log(double(5));    // 10
console.log(triple(5));    // 15
console.log(quadruple(5)); // 20

// Каждая функция "помнит" свой multiplier!'''),
                    const SizedBox(height: 24),

                    // 4. Классическая проблема с циклами
                    _buildSectionTitle('4. Проблема с циклами и var', Icons.loop),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Проблема: все функции выводят 3
for (var i = 0; i < 3; i++) {
  setTimeout(function() {
    console.log("var:", i); // 3, 3, 3
  }, 100);
}

// Решение 1: Использовать let
for (let i = 0; i < 3; i++) {
  setTimeout(function() {
    console.log("let:", i); // 0, 1, 2
  }, 100);
}

// Решение 2: IIFE (Immediately Invoked Function Expression)
for (var i = 0; i < 3; i++) {
  (function(j) {
    setTimeout(function() {
      console.log("IIFE:", j); // 0, 1, 2
    }, 100);
  })(i);
}

// Решение 3: bind
for (var i = 0; i < 3; i++) {
  setTimeout(function(index) {
    console.log("bind:", index); // 0, 1, 2
  }.bind(null, i), 100);
}'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '💡 Объяснение',
                      'var создает одну переменную для всего цикла. let создает новую переменную для каждой итерации. IIFE создает новую область видимости.',
                      AppColors.primary,
                    ),
                    const SizedBox(height: 24),

                    // 5. Модульный паттерн
                    _buildSectionTitle('5. Модульный паттерн', Icons.widgets),
                    const SizedBox(height: 12),
                    _buildCodeBlock(r'''// Создание модуля с приватными методами
const Calculator = (function() {
  // Приватные переменные и методы
  let history = [];
  
  function addToHistory(operation, result) {
    history.push({operation, result, timestamp: new Date()});
  }
  
  function validateNumbers(a, b) {
    if (typeof a !== 'number' || typeof b !== 'number') {
      throw new Error('Аргументы должны быть числами');
    }
  }
  
  // Публичный API
  return {
    add: function(a, b) {
      validateNumbers(a, b);
      const result = a + b;
      addToHistory(`${a} + ${b}`, result);
      return result;
    },
    
    subtract: function(a, b) {
      validateNumbers(a, b);
      const result = a - b;
      addToHistory(`${a} - ${b}`, result);
      return result;
    },
    
    getHistory: function() {
      return [...history]; // Возвращаем копию
    },
    
    clearHistory: function() {
      history = [];
    }
  };
})();

// Использование модуля
console.log(Calculator.add(5, 3));      // 8
console.log(Calculator.subtract(10, 4)); // 6
console.log(Calculator.getHistory());    // История операций

// Приватные методы недоступны
// Calculator.addToHistory(); // undefined'''),
                    const SizedBox(height: 24),

                    // 6. Замыкания и память
                    _buildSectionTitle('6. Замыкания и управление памятью', Icons.memory),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Замыкания могут привести к утечкам памяти, если не управлять ими правильно. Важно понимать жизненный цикл замыканий.',
                    ),
                    const SizedBox(height: 12),
                    _buildCodeBlock(r'''// Потенциальная утечка памяти
function createHandler() {
  const largeData = new Array(1000000).fill('data');
  
  return function(event) {
    // Функция замыкает largeData, даже если не использует
    console.log('Event handled');
  };
}

// Лучше: освобождаем ненужные ссылки
function createHandlerBetter() {
  const largeData = new Array(1000000).fill('data');
  
  // Обрабатываем данные сразу
  const processedData = largeData.length;
  
  return function(event) {
    // Замыкаем только нужные данные
    console.log(`Event handled, data size: ${processedData}`);
  };
}

// Очистка замыканий
let handler = createHandler();
// ... использование handler
handler = null; // Освобождаем ссылку'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '⚠️ Осторожно!',
                      'Замыкания сохраняют ссылки на все переменные внешней области видимости. Будьте внимательны с большими объектами.',
                      AppColors.warning,
                    ),
                    const SizedBox(height: 24),

                    // 7. Практическое задание
                    _buildSectionTitle('7. Практическое применение', Icons.assignment),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Создадим систему кэширования с использованием замыканий:',
                    ),
                    const SizedBox(height: 12),
                    _buildCodeBlock(r'''// Мемоизация - кэширование результатов функций
function memoize(fn) {
  const cache = new Map();
  
  return function(...args) {
    const key = JSON.stringify(args);
    
    if (cache.has(key)) {
      console.log('Результат из кэша');
      return cache.get(key);
    }
    
    console.log('Вычисляем результат');
    const result = fn.apply(this, args);
    cache.set(key, result);
    return result;
  };
}

// Дорогая функция для вычислений
function expensiveCalculation(n) {
  let result = 0;
  for (let i = 0; i < n * 1000000; i++) {
    result += i;
  }
  return result;
}

// Создаем мемоизированную версию
const memoizedCalc = memoize(expensiveCalculation);

console.time('Первый вызов');
memoizedCalc(100); // Вычисляем
console.timeEnd('Первый вызов');

console.time('Второй вызов');
memoizedCalc(100); // Из кэша!
console.timeEnd('Второй вызов');'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '🚀 Попробуй сам!',
                      'Создай свою функцию с замыканием! Попробуй сделать генератор уникальных ID или систему подписок на события.',
                      AppColors.success,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Кнопка завершения урока
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _showCompletionDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Завершить урок',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.firaCode(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTheoryBlock(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.firaCode(
          fontSize: 16,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildCodeBlock(String code) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Icon(
                Icons.code,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'JavaScript',
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            code,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightBox(String title, String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.firaCode(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubsection(String title, List<String> points) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: GoogleFonts.firaCode(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
          ],
          ...points.map((point) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_right,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
                    style: GoogleFonts.firaCode(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context) {
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
                'Урок завершен! 🎉',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Поздравляем! Теперь вы понимаете:\n\n• Область видимости в JavaScript\n• Что такое замыкания\n• Практическое применение\n• Модульный паттерн\n• Управление памятью\n\nВы готовы к продвинутым темам!',
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
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'К модулям',
                        style: GoogleFonts.firaCode(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
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
                      ),
                      child: Text(
                        'Отлично!',
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
} 