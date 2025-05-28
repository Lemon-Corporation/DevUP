import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AIInterviewScreen extends StatefulWidget {
  @override
  _AIInterviewScreenState createState() => _AIInterviewScreenState();
}

class _AIInterviewScreenState extends State<AIInterviewScreen> {
  final TextEditingController _answerController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isRecording = false;
  int _currentQuestionIndex = 0;
  
  final List<String> _questions = [
    "Объясните разницу между обучением с учителем и обучением без учителя.",
    "Что такое компромисс между смещением и дисперсией?",
    "Объясните, как работают деревья решений.",
    "Что такое градиентный спуск и как он работает?",
    "Объясните понятие переобучения и как его предотвратить.",
    "Расскажите о себе и своем опыте в программировании.",
    "Какие проекты вы реализовали и какие технологии использовали?",
    "Как вы подходите к решению сложных технических задач?",
    "Расскажите о вашем опыте работы в команде.",
    "Какие технологии вы хотели бы изучить в будущем?",
  ];

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _answerController.addListener(() {
      setState(() {});
    });
  }

  void _initSpeech() async {
    try {
      bool available = await _speech.initialize(
        onError: (error) {
          print("🔧 DEBUG: Speech recognition error: $error");
          setState(() {
            _isRecording = false;
          });
        },
        onStatus: (status) {
          print("🔧 DEBUG: Speech recognition status: $status");
        },
      );
      
      if (!available) {
        print("🔧 DEBUG: Speech recognition not available");
        // Можно показать пользователю уведомление
        Get.snackbar(
          "Внимание",
          "Распознавание речи недоступно на этом устройстве",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.warning ?? Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("🔧 DEBUG: Error initializing speech: $e");
      // Обработка ошибки инициализации
    }
  }

  void _startListening() async {
    try {
      if (!_isRecording && _speech.isAvailable) {
        setState(() {
          _isRecording = true;
        });
        await _speech.listen(
          onResult: (result) {
            setState(() {
              _answerController.text = result.recognizedWords;
            });
          },
          listenFor: Duration(seconds: 30),
          pauseFor: Duration(seconds: 3),
          partialResults: true,
          localeId: "ru_RU",
          onSoundLevelChange: (level) {
            // Можно добавить визуальную индикацию уровня звука
          },
        );
      } else if (!_speech.isAvailable) {
        Get.snackbar(
          "Ошибка",
          "Распознавание речи недоступно",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error ?? Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("🔧 DEBUG: Error starting listening: $e");
      setState(() {
        _isRecording = false;
      });
      Get.snackbar(
        "Ошибка",
        "Не удалось запустить распознавание речи",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error ?? Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _stopListening() async {
    try {
      if (_isRecording) {
        await _speech.stop();
        setState(() {
          _isRecording = false;
        });
      }
    } catch (e) {
      print("🔧 DEBUG: Error stopping listening: $e");
      setState(() {
        _isRecording = false;
      });
    }
  }

  void _sendAnswer() {
    if (_answerController.text.trim().isNotEmpty) {
      // Здесь можно добавить логику отправки ответа
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
                "Спасибо за участие в AI собеседовании",
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
                  "AI Собеседование",
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
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFE8E8FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.smart_toy,
                  color: AppColors.primary,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  "AI",
                  style: GoogleFonts.firaCode(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
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
            Color(0xFF9B59B6),
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
      child: Stack(
        children: [
          Center(
            child: Text(
              "🤖",
              style: TextStyle(fontSize: 50),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFF4A90E2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  "?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
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
                "AI Интервьюер",
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
            hintText: 'Введите ваш ответ здесь или используйт...',
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
            onPressed: _isRecording ? _stopListening : _startListening,
            icon: Icon(
              _isRecording ? Icons.stop : Icons.mic,
              color: Colors.white,
            ),
            label: Text(
              _isRecording ? 'Остановить' : 'Голосовой ввод',
              style: GoogleFonts.firaCode(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF00C9B1),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _answerController.text.trim().isEmpty ? null : _sendAnswer,
            icon: Icon(
              Icons.send,
              color: _answerController.text.trim().isEmpty ? Colors.grey : Colors.white,
            ),
            label: Text(
              'Отправить',
              style: GoogleFonts.firaCode(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _answerController.text.trim().isEmpty ? Colors.grey : Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _answerController.text.trim().isEmpty 
                  ? Color(0xFFE0E0E0)
                  : Color(0xFF9E9E9E),
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
    if (_isRecording) {
      _speech.stop();
    }
    super.dispose();
  }
} 