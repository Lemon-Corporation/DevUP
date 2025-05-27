import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/Data/js_test_data.dart';
import 'package:devup/Services/progress_manager.dart';

class EnhancedTestScreen extends StatefulWidget {
  final Map<String, dynamic> testData;
  final String courseId;
  final String track;

  const EnhancedTestScreen({
    Key? key,
    required this.testData,
    required this.courseId,
    required this.track,
  }) : super(key: key);

  @override
  _EnhancedTestScreenState createState() => _EnhancedTestScreenState();
}

class _EnhancedTestScreenState extends State<EnhancedTestScreen>
    with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int? selectedAnswer;
  bool showExplanation = false;
  bool isCorrect = false;
  List<bool> answeredQuestions = [];
  List<bool> correctAnswers = [];
  int score = 0;
  bool testCompleted = false;
  
  late AnimationController _progressController;
  late AnimationController _feedbackController;
  late Animation<double> _progressAnimation;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    
    // Инициализируем списки ответов
    final questions = widget.testData['questions'] as List;
    answeredQuestions = List.filled(questions.length, false);
    correctAnswers = List.filled(questions.length, false);
    
    // Инициализируем анимации
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
    
    _feedbackAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.elasticOut,
    ));
    
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _selectAnswer(int answerIndex) {
    if (showExplanation) return;
    
    setState(() {
      selectedAnswer = answerIndex;
    });
  }

  void _submitAnswer() {
    if (selectedAnswer == null) return;
    
    final questions = widget.testData['questions'] as List;
    final currentQuestion = questions[currentQuestionIndex];
    final correctAnswerIndex = currentQuestion['correctAnswer'] as int;
    
    setState(() {
      showExplanation = true;
      isCorrect = selectedAnswer == correctAnswerIndex;
      answeredQuestions[currentQuestionIndex] = true;
      correctAnswers[currentQuestionIndex] = isCorrect;
      
      if (isCorrect) {
        score++;
      }
    });
    
    _feedbackController.forward();
  }

  void _nextQuestion() {
    final questions = widget.testData['questions'] as List;
    
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showExplanation = false;
        isCorrect = false;
      });
      
      _feedbackController.reset();
      _progressController.forward();
    } else {
      _completeTest();
    }
  }

  void _completeTest() {
    setState(() {
      testCompleted = true;
    });
    
    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    final questions = widget.testData['questions'] as List;
    final percentage = (score / questions.length * 100).round();
    final isPassed = percentage >= 70;
    
    // Обновляем прогресс если тест пройден
    if (isPassed) {
      final testId = widget.testData['id'] as String;
      final xpReward = widget.testData['xpReward'] as int;
      ProgressManager.completeTest(testId, xpReward);
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
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
                  color: isPassed 
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  isPassed ? Icons.check_circle : Icons.info,
                  color: isPassed ? AppColors.success : AppColors.warning,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isPassed ? 'Тест пройден! 🎉' : 'Тест завершен',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Результат: $score из ${questions.length} ($percentage%)',
                style: GoogleFonts.firaCode(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isPassed ? AppColors.success : AppColors.warning,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isPassed 
                    ? 'Отличная работа! Вы получили ${widget.testData['xpReward']} XP'
                    : 'Для прохождения нужно 70%. Попробуйте еще раз!',
                textAlign: TextAlign.center,
                style: GoogleFonts.firaCode(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              if (isPassed) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Прогресс обновлен!',
                        style: GoogleFonts.firaCode(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.trending_up, color: AppColors.success, size: 20),
                              Text(
                                '${(ProgressManager.getCurrentProgress() * 100).round()}%',
                                style: GoogleFonts.firaCode(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Прогресс',
                                style: GoogleFonts.firaCode(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Text(
                                '${ProgressManager.getCurrentXP()}',
                                style: GoogleFonts.firaCode(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Общий XP',
                                style: GoogleFonts.firaCode(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  if (!isPassed)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _restartTest();
                        },
                        child: Text(
                          'Повторить',
                          style: GoogleFonts.firaCode(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop(isPassed); // Возвращаем результат
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isPassed ? AppColors.success : AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Продолжить',
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

  void _restartTest() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      showExplanation = false;
      isCorrect = false;
      score = 0;
      testCompleted = false;
      
      final questions = widget.testData['questions'] as List;
      answeredQuestions = List.filled(questions.length, false);
      correctAnswers = List.filled(questions.length, false);
    });
    
    _progressController.reset();
    _feedbackController.reset();
    _progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.testData['questions'] as List;
    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.testData['title'],
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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${currentQuestionIndex + 1}/${questions.length}',
              style: GoogleFonts.firaCode(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Прогресс бар
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Прогресс',
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: progress * _progressAnimation.value,
                      backgroundColor: AppColors.surface,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      minHeight: 8,
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Основной контент
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Вопрос
                  _buildQuestionCard(currentQuestion),
                  const SizedBox(height: 20),
                  
                  // Варианты ответов
                  _buildAnswerOptions(currentQuestion),
                  const SizedBox(height: 20),
                  
                  // Код (если есть)
                  if (widget.testData['codeSnippet'] != null)
                    _buildCodeSnippet(),
                  
                  // Объяснение (если показано)
                  if (showExplanation)
                    _buildExplanation(currentQuestion),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          
          // Кнопки действий
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> question) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.quiz,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Вопрос ${currentQuestionIndex + 1}',
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            question['question'],
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

  Widget _buildAnswerOptions(Map<String, dynamic> question) {
    final options = question['options'] as List<String>;
    final correctAnswerIndex = question['correctAnswer'] as int;
    
    return Column(
      children: options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        
        Color? backgroundColor;
        Color? borderColor;
        Color? textColor;
        IconData? icon;
        
        if (showExplanation) {
          if (index == correctAnswerIndex) {
            backgroundColor = AppColors.success.withOpacity(0.1);
            borderColor = AppColors.success;
            textColor = AppColors.success;
            icon = Icons.check_circle;
          } else if (index == selectedAnswer) {
            backgroundColor = AppColors.error.withOpacity(0.1);
            borderColor = AppColors.error;
            textColor = AppColors.error;
            icon = Icons.cancel;
          } else {
            backgroundColor = AppColors.surface;
            borderColor = AppColors.surface;
            textColor = AppColors.textSecondary;
          }
        } else {
          if (index == selectedAnswer) {
            backgroundColor = AppColors.primary.withOpacity(0.1);
            borderColor = AppColors.primary;
            textColor = AppColors.primary;
          } else {
            backgroundColor = AppColors.surface;
            borderColor = AppColors.surface;
            textColor = AppColors.textPrimary;
          }
        }
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () => _selectAnswer(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderColor!,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: textColor!,
                        width: 2,
                      ),
                      color: index == selectedAnswer && !showExplanation
                          ? textColor
                          : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + index), // A, B, C, D
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: index == selectedAnswer && !showExplanation
                              ? Colors.white
                              : textColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      option,
                      style: GoogleFonts.firaCode(
                        fontSize: 14,
                        color: textColor,
                        fontWeight: showExplanation && index == correctAnswerIndex
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (showExplanation && icon != null)
                    Icon(
                      icon,
                      color: textColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCodeSnippet() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
                'Код для анализа',
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
            widget.testData['codeSnippet'],
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

  Widget _buildExplanation(Map<String, dynamic> question) {
    return AnimatedBuilder(
      animation: _feedbackAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _feedbackAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isCorrect 
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCorrect ? AppColors.success : AppColors.error,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? AppColors.success : AppColors.error,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCorrect ? 'Правильно!' : 'Неправильно',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  isCorrect 
                      ? question['explanation']
                      : question['wrongExplanation'],
                  style: GoogleFonts.firaCode(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (!showExplanation)
            Expanded(
              child: ElevatedButton(
                onPressed: selectedAnswer != null ? _submitAnswer : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Ответить',
                  style: GoogleFonts.firaCode(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (showExplanation)
            Expanded(
              child: ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentQuestionIndex < widget.testData['questions'].length - 1
                          ? 'Следующий вопрос'
                          : 'Завершить тест',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      currentQuestionIndex < widget.testData['questions'].length - 1
                          ? Icons.arrow_forward
                          : Icons.check,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
} 