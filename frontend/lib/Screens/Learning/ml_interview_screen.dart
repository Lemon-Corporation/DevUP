import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:devup/Values/values.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:google_fonts/google_fonts.dart';

class MLInterviewScreen extends StatefulWidget {
  const MLInterviewScreen({Key? key}) : super(key: key);

  @override
  _MLInterviewScreenState createState() => _MLInterviewScreenState();
}

class _MLInterviewScreenState extends State<MLInterviewScreen> {
  late VideoPlayerController _controller;
  Timer? _timer;
  int _seconds = 120; // 2 minute timer for each question
  final TextEditingController _textController = TextEditingController();
  int _currentQuestionIndex = 0;
  bool _isRecording = false;
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _recognizedText = '';
  bool _isAnswering = false;
  bool _isInterviewStarted = false;

  // Sample ML interview questions
  final List<String> _questions = [
    "Объясните разницу между обучением с учителем и обучением без учителя.",
    "Что такое компромисс между смещением и дисперсией?",
    "Объясните, как работают деревья решений.",
    "Что такое градиентный спуск и как он работает?",
    "Объясните понятие переобучения и как его предотвратить.",
    "В чем разница между L1 и L2 регуляризацией?",
    "Объясните, как работают нейронные сети.",
    "Какова цель функций активации в нейронных сетях?",
    "Как работает метод обратного распространения ошибки?",
    "Объясните понятия точности и полноты в машинном обучении.",
  ];

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initVideoPlayer();
  }

  void _initVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/videos/AI_Interview.MP4')
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        if (_isInterviewStarted) {
          _controller.play();
        }
      }).catchError((error) {
        print("Ошибка инициализации видео: $error");
        // Можно добавить показ снэкбара с ошибкой
        /*
        Get.snackbar(
          "Ошибка",
          "Не удалось загрузить видео. Пожалуйста, попробуйте позже.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
        */
      });
  }

  void _initSpeech() async {
    await _speech.initialize();
  }

  void _startInterview() {
    setState(() {
      _isInterviewStarted = true;
    });
    
    if (_controller.value.isInitialized) {
      _controller.play();
    }
    
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          _nextQuestion();
        }
      });
    });
  }

  void _startListening() async {
    setState(() {
      _isRecording = true;
      _recognizedText = '';
    });
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedText = result.recognizedWords;
          _textController.text = _recognizedText;
        });
      },
    );
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() {
      _isRecording = false;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _seconds = 120;
        _textController.clear();
        _recognizedText = '';
        _isAnswering = false;
        _startTimer();
      } else {
        // End of interview
        _finishInterview();
      }
    });
  }

  void _finishInterview() {
    _timer?.cancel();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.success,
                  size: 36,
                ),
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
                "Вы успешно прошли все вопросы ML собеседования",
                textAlign: TextAlign.center,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.xp,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "+150 XP",
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.xp,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(
                    Icons.bolt,
                    color: AppColors.energy,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "+5 Энергии",
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.energy,
                    ),
                  ),
                ],
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  "Вернуться на главную",
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
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

  void _submitAnswer() {
    setState(() {
      _isAnswering = true;
    });
    _timer?.cancel();
    // Here you could implement logic to evaluate the answer
    // For now, we're just showing it and moving to next question
    Future.delayed(const Duration(seconds: 3), () {
      _nextQuestion();
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _textController.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                Expanded(
                  child: _isInterviewStarted
                      ? _buildInterviewContent()
                      : _buildStartScreen(),
                ),
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
                  "AI Собеседование",
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  _isInterviewStarted
                      ? "Вопрос ${_currentQuestionIndex + 1}/${_questions.length}"
                      : "Machine Learning",
                  style: GoogleFonts.firaCode(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (_isInterviewStarted)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: _seconds < 30
                    ? AppColors.error.withOpacity(0.2)
                    : AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _formatTime(_seconds),
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _seconds < 30 ? AppColors.error : AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStartScreen() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Machine Learning Собеседование",
            style: TextStyle(
              fontFamily: 'Unbounded',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Аватар интервьюера
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.smart_toy,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Интервьюер",
                          style: TextStyle(
                            fontFamily: 'Unbounded',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          "Machine Learning специалист",
                          style: GoogleFonts.firaCode(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "О собеседовании",
                        style: TextStyle(
                          fontFamily: 'Unbounded',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Собеседование по Machine Learning включает 10 вопросов по темам:",
                        style: GoogleFonts.firaCode(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTopicItem("Обучение с учителем и без учителя"),
                      _buildTopicItem("Деревья решений и ансамбли"),
                      _buildTopicItem("Градиентный спуск и оптимизация"),
                      _buildTopicItem("Нейронные сети и глубокое обучение"),
                      _buildTopicItem("Оценка качества моделей"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.textLight.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Информация",
                        style: TextStyle(
                          fontFamily: 'Unbounded',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "На каждый вопрос вам будет дано 2 минуты. Вы можете отвечать текстом или использовать голосовой ввод.",
                        style: GoogleFonts.firaCode(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoItem(
                            icon: Icons.star,
                            text: "150 XP",
                            color: AppColors.xp,
                          ),
                          _buildInfoItem(
                            icon: Icons.bolt,
                            text: "5 Энергии",
                            color: AppColors.energy,
                          ),
                          _buildInfoItem(
                            icon: Icons.timer,
                            text: "~20 минут",
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Center(
            child: SizedBox(
              width: 280,
              child: ElevatedButton(
                onPressed: _startInterview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow),
                    SizedBox(width: 10),
                    Text(
                      "Начать собеседование",
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 18,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.firaCode(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTopicItem(String topic) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: 16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              topic,
              style: GoogleFonts.firaCode(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterviewContent() {
    return Column(
      children: [
        // Video player
        Container(
          width: double.infinity,
          height: 240,
          color: Colors.white,
          child: _controller.value.isInitialized
              ? Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.smart_toy,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "AI Интервьюер",
                              style: GoogleFonts.firaCode(
                                fontSize: 12,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Загрузка видео...",
                        style: GoogleFonts.firaCode(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        
        // Question display
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
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
                        color: AppColors.primary,
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
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  _questions[_currentQuestionIndex],
                  style: GoogleFonts.firaCode(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Answer area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _isAnswering
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 3,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Оценка вашего ответа...',
                          style: GoogleFonts.firaCode(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.textLight.withOpacity(0.3),
                            ),
                          ),
                          child: TextField(
                            controller: _textController,
                            maxLines: null,
                            expands: true,
                            style: GoogleFonts.firaCode(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Введите ваш ответ здесь или используйте голосовой ввод...',
                              hintStyle: GoogleFonts.firaCode(
                                fontSize: 14,
                                color: AppColors.textLight,
                              ),
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _isRecording ? _stopListening : _startListening,
                              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                              label: Text(
                                _isRecording ? 'Остановить' : 'Голосовой ввод',
                                style: GoogleFonts.firaCode(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isRecording ? AppColors.error : AppColors.secondary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _textController.text.isEmpty ? null : _submitAnswer,
                              icon: const Icon(Icons.send),
                              label: Text(
                                'Отправить',
                                style: GoogleFonts.firaCode(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
} 