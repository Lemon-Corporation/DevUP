import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class JsTheoryDetailedPage extends StatelessWidget {
  const JsTheoryDetailedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Подробная теория JavaScript',
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
                    _buildDataTypeCard('Строки (String)', 'Текстовые данные', '"Привет, мир!"', AppColors.success),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Числа (Number)', 'Целые и дробные числа', '42, 3.14, -7', AppColors.warning),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Булевы (Boolean)', 'Истина или ложь', 'true, false', AppColors.error),
                    const SizedBox(height: 8),
                    _buildDataTypeCard('Массивы (Array)', 'Список значений', '[1, 2, 3, "текст"]', AppColors.primary),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Примеры использования
let userName = "Максим";           // Строка
let userAge = 28;                 // Число
let isStudent = true;             // Булево значение
let hobbies = ["спорт", "музыка"]; // Массив'''),
                    const SizedBox(height: 24),

                    // 3. Операторы и выражения
                    _buildSectionTitle('3. Операторы и выражения', Icons.calculate),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Операторы позволяют выполнять действия с данными. Вот самые важные из них:',
                    ),
                    const SizedBox(height: 12),
                    _buildOperatorSection('Арифметические операторы', [
                      '+ (сложение): 5 + 3 = 8',
                      '- (вычитание): 10 - 4 = 6', 
                      '* (умножение): 6 * 7 = 42',
                      '/ (деление): 15 / 3 = 5',
                    ]),
                    const SizedBox(height: 12),
                    _buildOperatorSection('Операторы сравнения', [
                      '=== (строгое равенство): 5 === 5 → true',
                      '!== (строгое неравенство): 5 !== 3 → true',
                      '> (больше): 10 > 5 → true',
                      '< (меньше): 3 < 8 → true',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Практический пример
let price = 1000;
let discount = 200;
let finalPrice = price - discount;  // 800

let isExpensive = finalPrice > 500;  // true
console.log("Цена:", finalPrice);'''),
                    const SizedBox(height: 24),

                    // 4. Работа с консолью
                    _buildSectionTitle('4. Отладка в консоли браузера', Icons.terminal),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Консоль браузера — твой лучший друг при изучении JavaScript. Она поможет увидеть результаты и найти ошибки.',
                    ),
                    const SizedBox(height: 12),
                    _buildStepCard('1', 'Открой консоль', 'F12 → вкладка Console', Icons.keyboard),
                    const SizedBox(height: 8),
                    _buildStepCard('2', 'Выводи информацию', 'console.log("Привет!");', Icons.print),
                    const SizedBox(height: 8),
                    _buildStepCard('3', 'Проверяй переменные', 'console.log(myVariable);', Icons.search),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Полезные команды для консоли
console.log("Отладочное сообщение");
console.error("Ошибка!");
console.warn("Предупреждение");
console.table([1, 2, 3]);  // Красивая таблица'''),
                    const SizedBox(height: 12),
                    _buildHighlightBox(
                      '🚀 Попробуй сейчас!',
                      'Открой консоль браузера (F12) и введи: console.log("Я изучаю JavaScript!"). Нажми Enter и увидишь результат!',
                      AppColors.success,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Кнопка перехода к следующему модулю
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Показываем диалог завершения
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
                      'Перейти к следующему модулю',
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

  Widget _buildOperatorSection(String title, List<String> operators) {
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
          ...operators.map((op) => Padding(
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
                    op,
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

  Widget _buildStepCard(String number, String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
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
                number,
                style: GoogleFonts.firaCode(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
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
                Text(
                  description,
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
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
                'Поздравляем! 🎉',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Вы успешно изучили основы JavaScript!\n\nТеперь вы знаете:\n• Как работать с переменными\n• Основные типы данных\n• Операторы и выражения\n• Отладку в консоли',
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
                      },
                      child: Text(
                        'Продолжить изучение',
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
                        'К модулям',
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