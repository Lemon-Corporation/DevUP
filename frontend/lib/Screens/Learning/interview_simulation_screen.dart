import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';

class InterviewSimulationScreen extends StatefulWidget {
  @override
  _InterviewSimulationScreenState createState() => _InterviewSimulationScreenState();
}

class _InterviewSimulationScreenState extends State<InterviewSimulationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  bool _isInterviewStarted = false;
  bool _isInterviewFinished = false;
  int _currentQuestionIndex = 0;
  
  final List<String> _interviewQuestions = [
    "Расскажите о себе и своем опыте в программировании.",
    "Какие проекты вы реализовали с использованием React?",
    "Объясните разницу между props и state в React.",
    "Что такое виртуальный DOM и как он работает?",
    "Расскажите о жизненном цикле компонента в React.",
    "Что такое хуки в React и какие вы использовали?",
    "Как бы вы оптимизировали производительность React-приложения?",
    "Расскажите о вашем опыте работы с Redux или другими менеджерами состояний.",
    "Как вы тестируете React-компоненты?",
    "Какие инструменты разработчика вы используете при работе с React?",
  ];
  
  @override
  void initState() {
    super.initState();
    _addMessage(
      "Добро пожаловать на симуляцию собеседования! Я буду вашим интервьюером сегодня. Готовы начать?",
      false,
    );
  }
  
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
  
  void _startInterview() {
    setState(() {
      _isInterviewStarted = true;
      _addMessage(_interviewQuestions[_currentQuestionIndex], false);
    });
  }
  
  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      if (_currentQuestionIndex < _interviewQuestions.length) {
        _addMessage(_interviewQuestions[_currentQuestionIndex], false);
      } else {
        _finishInterview();
      }
    });
  }
  
  void _finishInterview() {
    setState(() {
      _isInterviewFinished = true;
      _addMessage(
        "Спасибо за ваши ответы! Интервью завершено. Вот мой отзыв:\n\n"
        "Сильные стороны:\n"
        "- Хорошее понимание основных концепций React\n"
        "- Четкие и структурированные ответы\n"
        "- Практический опыт с реальными проектами\n\n"
        "Области для улучшения:\n"
        "- Углубить знания о производительности React\n"
        "- Расширить опыт с тестированием компонентов\n\n"
        "Общая оценка: 85/100\n"
        "Вы получаете 150 XP и 5 единиц энергии!",
        false,
      );
    });
  }
  
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    final userMessage = _messageController.text.trim();
    _addMessage(userMessage, true);
    _messageController.clear();
    
    // Имитация задержки ответа AI
    Future.delayed(Duration(seconds: 2), () {
      if (!_isInterviewFinished) {
        if (_isInterviewStarted) {
          _addMessage(
            "Спасибо за ваш ответ! Вы хорошо объяснили концепцию.",
            false,
          );
          Future.delayed(Duration(seconds: 1), _nextQuestion);
        } else {
          _startInterview();
        }
      }
    });
  }
  
  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add(Message(
        text: text,
        isUser: isUser,
        timestamp: DateTime.now(),
      ));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: AppColors.background,
            position: "topLeft",
          ),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: _buildMessagesList(),
                ),
                if (!_isInterviewFinished)
                  _buildMessageInput(),
                if (_isInterviewFinished)
                  _buildInterviewResults(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 15),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Интервьюер",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  _isInterviewStarted
                      ? "Вопрос ${_currentQuestionIndex + 1}/${_interviewQuestions.length}"
                      : "Симуляция собеседования",
                  style: GoogleFonts.firaCode(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Frontend React",
              style: GoogleFonts.firaCode(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMessagesList() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: _messages.length,
      reverse: false,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }
  
  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 15,
          left: message.isUser ? 50 : 0,
          right: message.isUser ? 0 : 50,
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: message.isUser ? Colors.white : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              _formatTime(message.timestamp),
              style: GoogleFonts.firaCode(
                fontSize: 10,
                color: message.isUser ? Colors.white.withOpacity(0.7) : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.textLight.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _messageController,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: "Введите ваш ответ...",
                  hintStyle: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppColors.textLight,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInterviewResults() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: AppColors.xp,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                "Оценка: 85/100",
                style: GoogleFonts.firaCode(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.xp,
                    size: 20,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "+150 XP",
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
                  Icon(
                    Icons.bolt,
                    color: AppColors.energy,
                    size: 20,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "+5 энергии",
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
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Завершить",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatTime(DateTime timestamp) {
    return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
  }
}

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  
  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
} 