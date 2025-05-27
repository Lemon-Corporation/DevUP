import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class FunctionsPage extends StatelessWidget {
  const FunctionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Функции в JavaScript',
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
                      'Функции — это основа JavaScript! Они позволяют группировать код, делать его переиспользуемым и создавать мощные абстракции.',
                    ),
                    const SizedBox(height: 24),

                    // 1. Объявление функций
                    _buildSectionTitle('1. Способы объявления функций', Icons.functions),
                    const SizedBox(height: 12),
                    _buildSubsection('Function Declaration (Объявление функции):', [
                      'Поднимается полностью (hoisting)',
                      'Можно вызвать до объявления',
                      'Создает именованную функцию',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Function Declaration
console.log(sayHello()); // "Привет!" - работает!

function sayHello() {
  return "Привет!";
}

// Именованная функция доступна в области видимости
console.log(sayHello.name); // "sayHello"'''),
                    const SizedBox(height: 16),

                    _buildSubsection('Function Expression (Функциональное выражение):', [
                      'Не поднимается (hoisting)',
                      'Нельзя вызвать до объявления',
                      'Может быть анонимной или именованной',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Function Expression
console.log(greet()); // TypeError: greet is not a function

var greet = function() {
  return "Привет!";
};

// Именованное функциональное выражение
const namedFunc = function myFunc() {
  return "Именованная функция";
};
console.log(namedFunc.name); // "myFunc"'''),
                    const SizedBox(height: 16),

                    _buildSubsection('Arrow Functions (Стрелочные функции):', [
                      'Краткий синтаксис',
                      'Не имеют собственного this',
                      'Не имеют arguments объекта',
                      'Нельзя использовать как конструкторы',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Arrow Functions
const add = (a, b) => a + b;
const square = x => x * x;
const greet = () => "Привет!";

// Многострочные arrow functions
const processData = (data) => {
  const processed = data.map(x => x * 2);
  return processed.filter(x => x > 10);
};

console.log(add(5, 3)); // 8
console.log(square(4)); // 16'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '⚡ Важно!',
                      'Arrow functions наследуют this из окружающего контекста и не могут быть переопределены через call, apply или bind.',
                      AppColors.warning,
                    ),
                    const SizedBox(height: 24),

                    // 2. Параметры функций
                    _buildSectionTitle('2. Параметры и аргументы', Icons.input),
                    const SizedBox(height: 12),
                    _buildSubsection('Основные концепции:', [
                      'Параметры по умолчанию',
                      'Rest параметры (...args)',
                      'Деструктуризация параметров',
                      'Объект arguments (только в обычных функциях)',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock(r'''// Параметры по умолчанию
function greet(name = "Гость", age = 0) {
  return `Привет, ${name}! Тебе ${age} лет.`;
}

console.log(greet()); // "Привет, Гость! Тебе 0 лет."
console.log(greet("Анна", 25)); // "Привет, Анна! Тебе 25 лет."

// Rest параметры
function sum(first, ...numbers) {
  console.log(first); // первый аргумент
  console.log(numbers); // массив остальных аргументов
  return first + numbers.reduce((a, b) => a + b, 0);
}

console.log(sum(1, 2, 3, 4, 5)); // 15

// Деструктуризация параметров
function createUser({name, age, email = "не указан"}) {
  return `Пользователь: ${name}, ${age} лет, email: ${email}`;
}

const user = {name: "Иван", age: 30};
console.log(createUser(user));'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '💡 Полезно знать',
                      'Свойство func.length возвращает количество параметров ДО первого параметра с значением по умолчанию.',
                      AppColors.primary,
                    ),
                    const SizedBox(height: 24),

                    // 3. Возвращаемые значения
                    _buildSectionTitle('3. Возвращаемые значения', Icons.keyboard_return),
                    const SizedBox(height: 12),
                    _buildCodeBlock(r'''// Явный return
function multiply(a, b) {
  return a * b; // явно возвращаем результат
}

// Неявный return в arrow functions
const divide = (a, b) => a / b;

// Возврат объекта в arrow function (нужны скобки!)
const createPoint = (x, y) => ({x, y});

// Функция без return возвращает undefined
function noReturn() {
  console.log("Что-то делаем");
  // return undefined; - неявно
}

console.log(multiply(4, 5)); // 20
console.log(divide(10, 2)); // 5
console.log(createPoint(3, 4)); // {x: 3, y: 4}
console.log(noReturn()); // undefined'''),
                    const SizedBox(height: 24),

                    // 4. Hoisting (Поднятие)
                    _buildSectionTitle('4. Hoisting - поднятие функций', Icons.arrow_upward),
                    const SizedBox(height: 12),
                    _buildCodeBlock(r'''// Function declarations поднимаются полностью
console.log(hoistedFunc()); // "Я поднялась!" - работает!

function hoistedFunc() {
  return "Я поднялась!";
}

// Function expressions поднимаются только как переменные
console.log(notHoisted); // undefined
console.log(notHoisted()); // TypeError: notHoisted is not a function

var notHoisted = function() {
  return "Я не поднялась!";
};

// let и const в temporal dead zone
console.log(alsoNotHoisted()); // ReferenceError

const alsoNotHoisted = () => "Я тоже не поднялась!";'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '🔥 Лучшая практика',
                      'Объявляйте функции до их использования для лучшей читаемости кода, даже если hoisting это позволяет.',
                      AppColors.success,
                    ),
                    const SizedBox(height: 24),

                    // 5. Практический пример
                    _buildSectionTitle('5. Практический пример', Icons.code),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Создадим систему для работы с пользователями, используя разные типы функций:',
                    ),
                    const SizedBox(height: 12),
                    _buildCodeBlock(r'''// Система управления пользователями
const users = [];

// Function declaration для основных операций
function addUser(name, age, email) {
  const user = {
    id: Date.now(),
    name,
    age,
    email,
    createdAt: new Date()
  };
  users.push(user);
  return user;
}

// Arrow function для поиска
const findUserById = (id) => users.find(user => user.id === id);

// Function expression для сложной логики
const validateUser = function(user) {
  const errors = [];
  
  if (!user.name || user.name.length < 2) {
    errors.push("Имя должно содержать минимум 2 символа");
  }
  
  if (!user.age || user.age < 0 || user.age > 120) {
    errors.push("Возраст должен быть от 0 до 120 лет");
  }
  
  if (!user.email || !user.email.includes("@")) {
    errors.push("Email должен содержать символ @");
  }
  
  return {
    isValid: errors.length === 0,
    errors
  };
};

// Использование системы
const newUser = addUser("Анна", 25, "anna@example.com");
const validation = validateUser(newUser);

console.log("Пользователь создан:", newUser);
console.log("Валидация:", validation);

const foundUser = findUserById(newUser.id);
console.log("Найденный пользователь:", foundUser);'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '🚀 Попробуй сам!',
                      'Открой консоль браузера и создай свои функции! Попробуй разные способы объявления и посмотри на различия.',
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
          Text(
            title,
            style: GoogleFonts.firaCode(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
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
                'Отлично! Теперь вы знаете:\n\n• Способы объявления функций\n• Hoisting и его особенности\n• Параметры и аргументы\n• Возвращаемые значения\n\nГотовы к изучению замыканий!',
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