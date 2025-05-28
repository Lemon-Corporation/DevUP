import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class SimpleInterviewScreen extends StatefulWidget {
  @override
  _SimpleInterviewScreenState createState() => _SimpleInterviewScreenState();
}

class _SimpleInterviewScreenState extends State<SimpleInterviewScreen> {
  final TextEditingController _answerController = TextEditingController();
  int _currentQuestionIndex = 0;
  
  final List<String> _questions = [
    "Расскажите о себе и своем опыте в программировании.",
    "Какие проекты вы реализовали и какие технологии использовали?",
    "Как вы подходите к решению сложных технических задач?",
    "Расскажите о вашем опыте работы в команде.",
    "Какие технологии вы хотели бы изучить в будущем?",
    "Объясните разницу между обучением с учителем и обучением без учителя.",
    "Что такое компромисс между смещением и дисперсией?",
    "Объясните, как работают деревья решений.",
    "Что такое градиентный спуск и как он работает?",
    "Объясните понятие переобучения и как его предотвратить.",
  ];

  @override
  void initState() {
    super.initState();
    _answerController.addListener(() {
      setState(() {});
    });
  }

  void _sendAnswer() {
    if (_answerController.text.trim().isNotEmpty) {
      Get.snackbar(
        "Ответ отправлен",
        "Ваш ответ был успешно отправлен",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
      
      // Переход к следующему вопросу
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _answerController.clear();
        });
      } else {
        // Завершение интервью
        _finishInterview();
      }
    }
  }

  void _finishInterview() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 60,
              ),
              SizedBox(height: 20),
              Text(
                "Собеседование завершено!",
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Спасибо за участие в собеседовании",
                textAlign: TextAlign.center,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Закрыть",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    _buildAIAvatar(),
                    SizedBox(height: 30),
                    _buildQuestionCard(),
                    SizedBox(height: 30),
                    _buildAnswerField(),
                    SizedBox(height: 20),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4A90E2),
                  Color(0xFF50E3C2),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "🤖",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Собеседование",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Вопрос ${_currentQuestionIndex + 1}/${_questions.length}",
                  style: GoogleFonts.firaCode(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIAvatar() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A90E2),
            Color(0xFF50E3C2),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4A90E2).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          "🤖",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFE8F4FD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF4A90E2).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(0xFF4A90E2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${_currentQuestionIndex + 1}",
                    style: GoogleFonts.firaCode(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Интервьюер",
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A90E2),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            _questions[_currentQuestionIndex],
            style: GoogleFonts.firaCode(
              fontSize: 16,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerField() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: TextField(
          controller: _answerController,
          maxLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.top,
          style: GoogleFonts.firaCode(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'Введите ваш ответ здесь...',
            hintStyle: GoogleFonts.firaCode(
              fontSize: 16,
              color: Colors.grey,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _answerController.text.trim().isEmpty ? null : _sendAnswer,
            icon: Icon(
              Icons.send,
              color: _answerController.text.trim().isEmpty ? Colors.grey : Colors.white,
            ),
            label: Text(
              'Отправить ответ',
              style: GoogleFonts.firaCode(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _answerController.text.trim().isEmpty ? Colors.grey : Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _answerController.text.trim().isEmpty 
                  ? Color(0xFFE0E0E0)
                  : AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
} 