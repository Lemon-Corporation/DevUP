import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class OperatorsExpressionsPage extends StatelessWidget {
  const OperatorsExpressionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Операторы и выражения',
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
                      'Операторы позволяют выполнять действия с данными: вычисления, сравнения, логические операции. Изучим самые важные из них!',
                    ),
                    const SizedBox(height: 24),

                    // 1. Арифметические операторы
                    _buildSectionTitle('1. Арифметические операторы', Icons.calculate),
                    const SizedBox(height: 12),
                    _buildOperatorSection('Основные арифметические операции:', [
                      '+ (сложение): 5 + 3 = 8',
                      '- (вычитание): 10 - 4 = 6', 
                      '* (умножение): 6 * 7 = 42',
                      '/ (деление): 15 / 3 = 5',
                      '% (остаток от деления): 10 % 3 = 1',
                      '** (возведение в степень): 2 ** 3 = 8',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Примеры арифметических операций
let a = 10;
let b = 3;

console.log(a + b);  // 13
console.log(a - b);  // 7
console.log(a * b);  // 30
console.log(a / b);  // 3.333...
console.log(a % b);  // 1 (остаток)
console.log(a ** b); // 1000 (10 в степени 3)'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '💡 Полезно знать',
                      'Оператор % (модуло) очень полезен! Например, для проверки четности числа: if (number % 2 === 0) - число четное.',
                      AppColors.primary,
                    ),
                    const SizedBox(height: 24),

                    // 2. Операторы сравнения
                    _buildSectionTitle('2. Операторы сравнения', Icons.compare_arrows),
                    const SizedBox(height: 12),
                    _buildOperatorSection('Сравнение значений:', [
                      '=== (строгое равенство): 5 === 5 → true',
                      '!== (строгое неравенство): 5 !== 3 → true',
                      '== (нестрогое равенство): "5" == 5 → true',
                      '!= (нестрогое неравенство): "5" != 3 → true',
                      '> (больше): 10 > 5 → true',
                      '< (меньше): 3 < 8 → true',
                      '>= (больше или равно): 5 >= 5 → true',
                      '<= (меньше или равно): 3 <= 8 → true',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Примеры сравнений
let age = 18;
let name = "Анна";

console.log(age === 18);        // true
console.log(age !== 20);        // true
console.log(age >= 18);         // true
console.log(name === "Анна");   // true

// Осторожно с нестрогим сравнением!
console.log("5" == 5);          // true (приведение типов)
console.log("5" === 5);         // false (разные типы)'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '⚠️ Важно!',
                      'Всегда используй === и !== вместо == и !=. Строгое сравнение безопаснее и предсказуемее!',
                      AppColors.warning,
                    ),
                    const SizedBox(height: 24),

                    // 3. Логические операторы
                    _buildSectionTitle('3. Логические операторы', Icons.psychology),
                    const SizedBox(height: 12),
                    _buildOperatorSection('Работа с булевыми значениями:', [
                      '&& (И): true && true → true',
                      '|| (ИЛИ): true || false → true',
                      '! (НЕ): !true → false',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Логические операторы
let isAdult = true;
let hasLicense = false;
let isWeekend = true;

// Оператор И (&&) - все условия должны быть true
console.log(isAdult && hasLicense);  // false

// Оператор ИЛИ (||) - хотя бы одно условие true
console.log(isAdult || hasLicense);  // true

// Оператор НЕ (!) - инверсия
console.log(!hasLicense);            // true
console.log(!isAdult);               // false

// Сложные условия
if (isAdult && (hasLicense || isWeekend)) {
  console.log("Можно водить машину!");
}'''),
                    const SizedBox(height: 24),

                    // 4. Операторы присваивания
                    _buildSectionTitle('4. Операторы присваивания', Icons.assignment),
                    const SizedBox(height: 12),
                    _buildOperatorSection('Сокращенные формы записи:', [
                      '+= (прибавить и присвоить): x += 5 → x = x + 5',
                      '-= (вычесть и присвоить): x -= 3 → x = x - 3',
                      '*= (умножить и присвоить): x *= 2 → x = x * 2',
                      '/= (разделить и присвоить): x /= 4 → x = x / 4',
                      '++ (инкремент): x++ → x = x + 1',
                      '-- (декремент): x-- → x = x - 1',
                    ]),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Операторы присваивания
let score = 100;

score += 50;    // score = 150
score -= 20;    // score = 130
score *= 2;     // score = 260
score /= 4;     // score = 65

// Инкремент и декремент
let lives = 3;
lives++;        // lives = 4
lives--;        // lives = 3

// Работа со строками
let message = "Привет";
message += ", мир!";  // "Привет, мир!"'''),
                    const SizedBox(height: 24),

                    // 5. Практический пример
                    _buildSectionTitle('5. Практический пример', Icons.code),
                    const SizedBox(height: 12),
                    _buildTheoryBlock(
                      'Давайте создадим простой калькулятор скидки в магазине:',
                    ),
                    const SizedBox(height: 12),
                    _buildCodeBlock('''// Калькулятор скидки
let originalPrice = 1000;
let discountPercent = 20;
let isVip = true;
let additionalDiscount = 5;

// Основная скидка
let discount = originalPrice * (discountPercent / 100);
let priceAfterDiscount = originalPrice - discount;

// Дополнительная скидка для VIP
if (isVip) {
  let vipDiscount = priceAfterDiscount * (additionalDiscount / 100);
  priceAfterDiscount -= vipDiscount;
}

// Проверяем результат
console.log("Исходная цена:", originalPrice);
console.log("Скидка:", discountPercent + "%");
console.log("VIP клиент:", isVip);
console.log("Итоговая цена:", priceAfterDiscount);

// Проверяем, выгодная ли покупка
let isGoodDeal = priceAfterDiscount < originalPrice * 0.7;
console.log("Выгодная покупка:", isGoodDeal);'''),
                    const SizedBox(height: 16),
                    _buildHighlightBox(
                      '🚀 Попробуй сам!',
                      'Открой консоль браузера и попробуй изменить значения переменных в примере выше. Посмотри, как изменится результат!',
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
                'Модуль завершен! 🎉',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Поздравляем! Ты изучил основы JavaScript:\n\n• Переменные и типы данных\n• Операторы и выражения\n• Практические примеры\n\nТеперь ты готов к более сложным темам!',
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