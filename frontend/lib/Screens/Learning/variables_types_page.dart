import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class VariablesTypesPage extends StatelessWidget {
  const VariablesTypesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Переменные и типы данных',
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
                    // 1. Переменные и их объявление
                    _buildSectionTitle('1. Переменные и их объявление', Icons.storage),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Переменные — это контейнеры для хранения данных. В JavaScript есть три способа объявления переменных:',
                    ),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''let name = "Анна";        // Можно изменить
const age = 25;          // Нельзя изменить  
var city = "Москва";     // Старый способ'''),
                    const SizedBox(height: 12),
                    _buildHighlightBox(
                      '💡 Совет',
                      'Используй let для изменяемых переменных и const для постоянных значений. Избегай var в современном коде!',
                      AppColors.primary,
                    ),
                    const SizedBox(height: 24),

                    // 2. Типы данных
                    _buildSectionTitle('2. Основные типы данных', Icons.category),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'JavaScript имеет несколько основных типов данных, которые ты будешь использовать постоянно:',
                    ),
                    const SizedBox(height: 12),
                    
                    // Примитивные типы
                    Text(
                      'Примитивные типы:',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('String (Строки)', 'Текстовые данные в кавычках', '"Привет, мир!", \'JavaScript\'', AppColors.success),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Number (Числа)', 'Целые и дробные числа', '42, 3.14, -7, Infinity', AppColors.warning),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Boolean (Булевы)', 'Логические значения', 'true, false', AppColors.error),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('undefined', 'Неопределенное значение', 'let x; // x = undefined', AppColors.textSecondary),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('null', 'Пустое значение', 'let data = null;', AppColors.textSecondary),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Symbol', 'Уникальный идентификатор', 'Symbol("id")', AppColors.primary),
                    
                    const SizedBox(height: 16),
                    Text(
                      'Сложные типы:',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Object (Объекты)', 'Коллекция свойств', '{name: "Анна", age: 25}', AppColors.primary),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Array (Массивы)', 'Упорядоченный список', '[1, 2, 3, "текст"]', AppColors.success),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Function (Функции)', 'Блоки кода для выполнения', 'function sayHello() {...}', AppColors.warning),
                    
                    const SizedBox(height: 16),
                    _buildCodeBlock('''// Примеры всех типов данных
let userName = "Максим";           // String
let userAge = 28;                 // Number
let isStudent = true;             // Boolean
let data = null;                  // null
let notDefined;                   // undefined
let uniqueId = Symbol("id");      // Symbol

let user = {                      // Object
  name: "Анна",
  age: 25
};

let hobbies = ["спорт", "музыка"]; // Array

function greet() {                // Function
  return "Привет!";
}'''),
                    const SizedBox(height: 16),
                    
                    // Проверка типов
                    _buildSectionTitle('3. Проверка типов данных', Icons.search),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Используй оператор typeof для проверки типа переменной:',
                    ),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''console.log(typeof "Привет");     // "string"
console.log(typeof 42);          // "number"
console.log(typeof true);        // "boolean"
console.log(typeof undefined);   // "undefined"
console.log(typeof null);        // "object" (особенность JS!)
console.log(typeof [1, 2, 3]);   // "object"
console.log(typeof {name: "Анна"}); // "object"'''),
                    
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '⚠️ Важно знать',
                      'typeof null возвращает "object" — это известная особенность JavaScript. Для проверки на null используй строгое сравнение: value === null',
                      AppColors.warning,
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

  Widget _buildDataTypeCard(String type, String description, String example, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.firaCode(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  example,
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
                'Отлично! Теперь ты знаешь:\n\n• Как объявлять переменные\n• Все типы данных JavaScript\n• Как проверять типы с typeof\n\nГотов изучать операторы?',
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
                        // Здесь можно добавить переход к следующему уроку
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Далее',
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