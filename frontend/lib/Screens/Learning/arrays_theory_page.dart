import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/Screens/Learning/destructuring_theory_page.dart';
import 'package:devup/Services/progress_manager.dart';

class ArraysTheoryPage extends StatelessWidget {
  const ArraysTheoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Массивы и методы массивов',
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
                    Text(
                      'Массивы — это упорядоченные коллекции элементов. Они идеально подходят для хранения списков данных.',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Иконка массива
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '[]',
                            style: GoogleFonts.firaCode(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'Создание массивов:',
                      style: GoogleFonts.firaCode(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Примеры создания массивов:',
                            style: GoogleFonts.firaCode(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '''// Литерал массива
const fruits = ["яблоко", "банан", "апельсин"];

// Конструктор Array
const numbers = new Array(1, 2, 3, 4, 5);

// Пустой массив
const empty = [];

// Массив с разными типами
const mixed = [1, "текст", true, null];''',
                              style: GoogleFonts.firaCode(
                                fontSize: 14,
                                color: Colors.blue[300],
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    Text(
                      'Основные методы массивов:',
                      style: GoogleFonts.firaCode(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    _buildMethodSection('Добавление и удаление:', [
                      {'method': 'push()', 'desc': 'Добавляет элемент в конец'},
                      {'method': 'pop()', 'desc': 'Удаляет последний элемент'},
                      {'method': 'unshift()', 'desc': 'Добавляет элемент в начало'},
                      {'method': 'shift()', 'desc': 'Удаляет первый элемент'},
                    ]),
                    
                    const SizedBox(height: 16),
                    _buildMethodSection('Поиск и проверка:', [
                      {'method': 'indexOf()', 'desc': 'Находит индекс элемента'},
                      {'method': 'includes()', 'desc': 'Проверяет наличие элемента'},
                      {'method': 'find()', 'desc': 'Находит элемент по условию'},
                      {'method': 'findIndex()', 'desc': 'Находит индекс по условию'},
                    ]),
                    
                    const SizedBox(height: 16),
                    _buildMethodSection('Преобразование:', [
                      {'method': 'map()', 'desc': 'Создает новый массив с преобразованными элементами'},
                      {'method': 'filter()', 'desc': 'Фильтрует элементы по условию'},
                      {'method': 'reduce()', 'desc': 'Сводит массив к одному значению'},
                      {'method': 'sort()', 'desc': 'Сортирует элементы массива'},
                    ]),
                    
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Пример использования методов:',
                            style: GoogleFonts.firaCode(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '''const numbers = [1, 2, 3, 4, 5];

// Удваиваем каждое число
const doubled = numbers.map(n => n * 2);
// [2, 4, 6, 8, 10]

// Фильтруем четные числа
const even = numbers.filter(n => n % 2 === 0);
// [2, 4]

// Сумма всех чисел
const sum = numbers.reduce((acc, n) => acc + n, 0);
// 15''',
                              style: GoogleFonts.firaCode(
                                fontSize: 14,
                                color: Colors.green[300],
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.1),
                            AppColors.success.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: AppColors.primary,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Важно помнить!',
                            style: GoogleFonts.firaCode(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Методы map(), filter(), reduce() не изменяют исходный массив, а создают новый!',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaCode(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Кнопка "Далее"
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Отмечаем урок как пройденный
                  ProgressManager.completeLesson('arrays_theory', xpReward: 15);
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DestructuringTheoryPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Изучить деструктуризацию',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
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

  Widget _buildMethodSection(String title, List<Map<String, String>> methods) {
    return Column(
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
        ...methods.map((method) => _buildMethodItem(method['method']!, method['desc']!)),
      ],
    );
  }

  Widget _buildMethodItem(String method, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                method,
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                description,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 