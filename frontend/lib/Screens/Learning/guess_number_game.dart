import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class GuessNumberGame extends StatefulWidget {
  const GuessNumberGame({Key? key}) : super(key: key);

  @override
  State<GuessNumberGame> createState() => _GuessNumberGameState();
}

class _GuessNumberGameState extends State<GuessNumberGame>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isCompleted = false;

  final List<String> _steps = [
    'HTML структура',
    'CSS стилизация',
    'JavaScript логика',
  ];

  final Map<int, bool> _stepCompleted = {
    0: false,
    1: false,
    2: false,
  };

  final Map<int, String> _stepCode = {
    0: r'''<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Угадай число</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🎯 Угадай число!</h1>
            <p class="subtitle">Я загадал число от 1 до 100. Попробуй угадать!</p>
        </header>

        <div class="game-area">
            <div class="stats">
                <div class="stat-item">
                    <span class="stat-label">Попытки:</span>
                    <span id="attempts" class="stat-value">0</span>
                </div>
                <div class="stat-item">
                    <span class="stat-label">Рекорд:</span>
                    <span id="bestScore" class="stat-value">-</span>
                </div>
                <div class="stat-item">
                    <span class="stat-label">Уровень:</span>
                    <span id="difficulty" class="stat-value">Легкий</span>
                </div>
            </div>

            <div class="input-section">
                <input type="number" id="guessInput" min="1" max="100" 
                       placeholder="Введите число от 1 до 100">
                <button id="submitGuess" class="btn-primary">Угадать!</button>
            </div>

            <div id="feedback" class="feedback hidden">
                <div id="feedbackIcon" class="feedback-icon"></div>
                <div id="feedbackText" class="feedback-text"></div>
                <div id="hint" class="hint"></div>
            </div>

            <div class="history-section">
                <h3>История попыток:</h3>
                <div id="guessHistory" class="guess-history"></div>
            </div>
        </div>

        <div class="controls">
            <button id="newGame" class="btn-secondary">Новая игра</button>
            <button id="changeDifficulty" class="btn-secondary">Сменить уровень</button>
            <button id="showHint" class="btn-hint">Подсказка</button>
        </div>

        <div id="winModal" class="modal hidden">
            <div class="modal-content">
                <h2>🎉 Поздравляем!</h2>
                <p id="winMessage"></p>
                <div class="modal-buttons">
                    <button id="playAgain" class="btn-primary">Играть еще</button>
                    <button id="closeModal" class="btn-secondary">Закрыть</button>
                </div>
            </div>
        </div>

        <div id="difficultyModal" class="modal hidden">
            <div class="modal-content">
                <h2>Выберите уровень сложности</h2>
                <div class="difficulty-options">
                    <button class="difficulty-btn" data-level="easy">
                        <strong>Легкий</strong><br>
                        1-100, неограниченные попытки
                    </button>
                    <button class="difficulty-btn" data-level="medium">
                        <strong>Средний</strong><br>
                        1-100, 10 попыток
                    </button>
                    <button class="difficulty-btn" data-level="hard">
                        <strong>Сложный</strong><br>
                        1-1000, 15 попыток
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>''',
    1: r'''/* style.css */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.container {
    background: white;
    border-radius: 20px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    padding: 2rem;
    width: 100%;
    max-width: 500px;
    animation: slideIn 0.5s ease-out;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

header {
    text-align: center;
    margin-bottom: 2rem;
}

h1 {
    color: #333;
    font-size: 2.5rem;
    margin-bottom: 0.5rem;
}

.subtitle {
    color: #666;
    font-size: 1.1rem;
}

.stats {
    display: flex;
    justify-content: space-around;
    background: #f8f9fa;
    border-radius: 15px;
    padding: 1rem;
    margin-bottom: 2rem;
}

.stat-item {
    text-align: center;
}

.stat-label {
    display: block;
    font-size: 0.9rem;
    color: #666;
    margin-bottom: 0.25rem;
}

.stat-value {
    display: block;
    font-size: 1.5rem;
    font-weight: bold;
    color: #333;
}

.input-section {
    display: flex;
    gap: 1rem;
    margin-bottom: 2rem;
}

input[type="number"] {
    flex: 1;
    padding: 1rem;
    border: 2px solid #ddd;
    border-radius: 10px;
    font-size: 1.1rem;
    text-align: center;
    transition: border-color 0.3s ease;
}

input[type="number"]:focus {
    outline: none;
    border-color: #667eea;
}

.btn-primary, .btn-secondary, .btn-hint {
    padding: 1rem 1.5rem;
    border: none;
    border-radius: 10px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
    background: #f8f9fa;
    color: #333;
    border: 2px solid #ddd;
}

.btn-secondary:hover {
    background: #e9ecef;
}

.btn-hint {
    background: #ffc107;
    color: #333;
}

.btn-hint:hover {
    background: #ffb300;
}

.feedback {
    text-align: center;
    padding: 1.5rem;
    border-radius: 15px;
    margin-bottom: 2rem;
    animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.feedback.too-high {
    background: #ffe6e6;
    border: 2px solid #ff6b6b;
}

.feedback.too-low {
    background: #e6f3ff;
    border: 2px solid #4dabf7;
}

.feedback.correct {
    background: #e6ffe6;
    border: 2px solid #51cf66;
}

.feedback-icon {
    font-size: 3rem;
    margin-bottom: 0.5rem;
}

.feedback-text {
    font-size: 1.2rem;
    font-weight: bold;
    margin-bottom: 0.5rem;
}

.hint {
    font-size: 0.9rem;
    color: #666;
}

.history-section h3 {
    color: #333;
    margin-bottom: 1rem;
    text-align: center;
}

.guess-history {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    justify-content: center;
    margin-bottom: 2rem;
}

.guess-item {
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: bold;
    font-size: 0.9rem;
}

.guess-item.too-high {
    background: #ffe6e6;
    color: #d63031;
}

.guess-item.too-low {
    background: #e6f3ff;
    color: #0984e3;
}

.controls {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
}

.modal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.modal-content {
    background: white;
    padding: 2rem;
    border-radius: 20px;
    text-align: center;
    max-width: 400px;
    width: 90%;
    animation: modalSlideIn 0.3s ease-out;
}

@keyframes modalSlideIn {
    from {
        opacity: 0;
        transform: scale(0.8);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}

.modal-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
    margin-top: 1.5rem;
}

.difficulty-options {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    margin-top: 1.5rem;
}

.difficulty-btn {
    padding: 1rem;
    border: 2px solid #ddd;
    border-radius: 10px;
    background: white;
    cursor: pointer;
    transition: all 0.3s ease;
}

.difficulty-btn:hover {
    border-color: #667eea;
    background: #f8f9ff;
}

.hidden {
    display: none !important;
}

@media (max-width: 480px) {
    .container {
        padding: 1rem;
    }
    
    h1 {
        font-size: 2rem;
    }
    
    .stats {
        flex-direction: column;
        gap: 1rem;
    }
    
    .input-section {
        flex-direction: column;
    }
    
    .controls {
        flex-direction: column;
    }
}''',
    2: r'''// script.js

// Создаем игровой модуль с использованием замыкания
const NumberGuessingGame = (function() {
    // Приватные переменные (замыкание)
    let secretNumber;
    let attempts;
    let gameHistory = [];
    let bestScore = localStorage.getItem('bestScore') || null;
    let currentDifficulty = 'easy';
    
    // Настройки уровней сложности
    const difficultySettings = {
        easy: { min: 1, max: 100, maxAttempts: Infinity, name: 'Легкий' },
        medium: { min: 1, max: 100, maxAttempts: 10, name: 'Средний' },
        hard: { min: 1, max: 1000, maxAttempts: 15, name: 'Сложный' }
    };
    
    // Получаем элементы DOM
    const elements = {
        guessInput: document.getElementById('guessInput'),
        submitBtn: document.getElementById('submitGuess'),
        feedback: document.getElementById('feedback'),
        feedbackIcon: document.getElementById('feedbackIcon'),
        feedbackText: document.getElementById('feedbackText'),
        hint: document.getElementById('hint'),
        attempts: document.getElementById('attempts'),
        bestScore: document.getElementById('bestScore'),
        difficulty: document.getElementById('difficulty'),
        guessHistory: document.getElementById('guessHistory'),
        newGameBtn: document.getElementById('newGame'),
        changeDifficultyBtn: document.getElementById('changeDifficulty'),
        showHintBtn: document.getElementById('showHint'),
        winModal: document.getElementById('winModal'),
        winMessage: document.getElementById('winMessage'),
        playAgainBtn: document.getElementById('playAgain'),
        closeModalBtn: document.getElementById('closeModal'),
        difficultyModal: document.getElementById('difficultyModal'),
        difficultyBtns: document.querySelectorAll('.difficulty-btn')
    };
    
    // Функция генерации случайного числа (чистая функция)
    function generateRandomNumber(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
    
    // Функция для создания элемента истории попыток
    function createGuessHistoryItem(guess, result) {
        const item = document.createElement('div');
        item.className = `guess-item ${result}`;
        item.textContent = guess;
        return item;
    }
    
    // Функция для отображения обратной связи
    function showFeedback(type, message, hintText = '') {
        elements.feedback.className = `feedback ${type}`;
        elements.feedback.classList.remove('hidden');
        
        // Устанавливаем иконку в зависимости от типа
        const icons = {
            'too-high': '📈',
            'too-low': '📉',
            'correct': '🎉'
        };
        
        elements.feedbackIcon.textContent = icons[type] || '🤔';
        elements.feedbackText.textContent = message;
        elements.hint.textContent = hintText;
    }
    
    // Функция для скрытия обратной связи
    function hideFeedback() {
        elements.feedback.classList.add('hidden');
    }
    
    // Функция для обновления статистики
    function updateStats() {
        elements.attempts.textContent = attempts;
        elements.bestScore.textContent = bestScore || '-';
        elements.difficulty.textContent = difficultySettings[currentDifficulty].name;
    }
    
    // Функция для обновления истории попыток
    function updateGuessHistory() {
        elements.guessHistory.innerHTML = '';
        gameHistory.forEach(item => {
            elements.guessHistory.appendChild(
                createGuessHistoryItem(item.guess, item.result)
            );
        });
    }
    
    // Функция для проверки догадки
    function checkGuess(guess) {
        attempts++;
        
        let result, message, hintText;
        
        if (guess === secretNumber) {
            result = 'correct';
            message = `Поздравляем! Вы угадали число ${secretNumber}!`;
            hintText = `Попыток использовано: ${attempts}`;
            
            // Обновляем лучший результат
            if (!bestScore || attempts < bestScore) {
                bestScore = attempts;
                localStorage.setItem('bestScore', bestScore);
            }
            
            // Показываем модальное окно победы
            setTimeout(() => showWinModal(), 1000);
            
        } else if (guess > secretNumber) {
            result = 'too-high';
            message = 'Слишком большое число!';
            hintText = getHint(guess);
            
        } else {
            result = 'too-low';
            message = 'Слишком маленькое число!';
            hintText = getHint(guess);
        }
        
        // Добавляем в историю
        gameHistory.push({ guess, result });
        
        // Показываем обратную связь
        showFeedback(result, message, hintText);
        
        // Обновляем интерфейс
        updateStats();
        updateGuessHistory();
        
        // Проверяем лимит попыток
        const settings = difficultySettings[currentDifficulty];
        if (attempts >= settings.maxAttempts && result !== 'correct') {
            setTimeout(() => {
                alert(`Игра окончена! Загаданное число было: ${secretNumber}`);
                startNewGame();
            }, 1500);
        }
    }
    
    // Функция для получения подсказки
    function getHint(guess) {
        const difference = Math.abs(guess - secretNumber);
        if (difference <= 5) return 'Очень близко! 🔥';
        if (difference <= 10) return 'Близко! 👍';
        if (difference <= 20) return 'Тепло! 😊';
        return 'Холодно! ❄️';
    }
    
    // Функция для показа модального окна победы
    function showWinModal() {
        const isNewRecord = bestScore === attempts;
        elements.winMessage.innerHTML = `
            Вы угадали число <strong>${secretNumber}</strong> за <strong>${attempts}</strong> ${attempts === 1 ? 'попытку' : attempts < 5 ? 'попытки' : 'попыток'}!
            ${isNewRecord ? '<br>🏆 Это новый рекорд!' : ''}
        `;
        elements.winModal.classList.remove('hidden');
    }
    
    // Функция для скрытия модального окна
    function hideWinModal() {
        elements.winModal.classList.add('hidden');
    }
    
    // Функция для показа модального окна выбора сложности
    function showDifficultyModal() {
        elements.difficultyModal.classList.remove('hidden');
    }
    
    // Функция для скрытия модального окна сложности
    function hideDifficultyModal() {
        elements.difficultyModal.classList.add('hidden');
    }
    
    // Функция для смены уровня сложности
    function changeDifficulty(newDifficulty) {
        currentDifficulty = newDifficulty;
        const settings = difficultySettings[currentDifficulty];
        
        // Обновляем placeholder и атрибуты input
        elements.guessInput.placeholder = `Введите число от ${settings.min} до ${settings.max}`;
        elements.guessInput.min = settings.min;
        elements.guessInput.max = settings.max;
        
        hideDifficultyModal();
        startNewGame();
    }
    
    // Функция для начала новой игры
    function startNewGame() {
        const settings = difficultySettings[currentDifficulty];
        
        secretNumber = generateRandomNumber(settings.min, settings.max);
        attempts = 0;
        gameHistory = [];
        
        // Сбрасываем интерфейс
        elements.guessInput.value = '';
        elements.guessInput.disabled = false;
        elements.submitBtn.disabled = false;
        hideFeedback();
        hideWinModal();
        
        // Обновляем статистику и историю
        updateStats();
        updateGuessHistory();
        
        // Фокусируемся на поле ввода
        elements.guessInput.focus();
        
        console.log(`Новая игра начата! Загаданное число: ${secretNumber} (для отладки)`);
    }
    
    // Функция для показа подсказки
    function showHintFunction() {
        if (attempts === 0) {
            alert('Сначала сделайте хотя бы одну попытку!');
            return;
        }
        
        const settings = difficultySettings[currentDifficulty];
        const range = settings.max - settings.min;
        const rangeSize = Math.floor(range / 10);
        const lowerBound = Math.max(settings.min, secretNumber - rangeSize);
        const upperBound = Math.min(settings.max, secretNumber + rangeSize);
        
        alert(`Подсказка: число находится в диапазоне от ${lowerBound} до ${upperBound}`);
    }
    
    // Функция инициализации игры
    function init() {
        // Обновляем лучший результат из localStorage
        updateStats();
        
        // Добавляем обработчики событий
        elements.submitBtn.addEventListener('click', function() {
            const guess = parseInt(elements.guessInput.value);
            const settings = difficultySettings[currentDifficulty];
            
            if (isNaN(guess) || guess < settings.min || guess > settings.max) {
                alert(`Пожалуйста, введите число от ${settings.min} до ${settings.max}`);
                return;
            }
            
            checkGuess(guess);
            elements.guessInput.value = '';
            elements.guessInput.focus();
        });
        
        // Обработчик для Enter в поле ввода
        elements.guessInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                elements.submitBtn.click();
            }
        });
        
        // Обработчики для кнопок
        elements.newGameBtn.addEventListener('click', startNewGame);
        elements.changeDifficultyBtn.addEventListener('click', showDifficultyModal);
        elements.showHintBtn.addEventListener('click', showHintFunction);
        elements.playAgainBtn.addEventListener('click', startNewGame);
        elements.closeModalBtn.addEventListener('click', hideWinModal);
        
        // Обработчики для кнопок выбора сложности
        elements.difficultyBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                changeDifficulty(this.dataset.level);
            });
        });
        
        // Закрытие модальных окон по клику вне их
        elements.winModal.addEventListener('click', function(e) {
            if (e.target === this) hideWinModal();
        });
        
        elements.difficultyModal.addEventListener('click', function(e) {
            if (e.target === this) hideDifficultyModal();
        });
        
        // Начинаем первую игру
        startNewGame();
    }
    
    // Публичный API модуля
    return {
        init: init,
        startNewGame: startNewGame,
        changeDifficulty: changeDifficulty,
        // Для отладки (можно убрать в продакшене)
        getSecretNumber: () => secretNumber,
        getCurrentDifficulty: () => currentDifficulty
    };
})();

// Инициализируем игру когда DOM загружен
document.addEventListener('DOMContentLoaded', function() {
    NumberGuessingGame.init();
});

// Дополнительные функции для демонстрации концепций

// Пример каррирования
const createRangeValidator = (min) => (max) => (value) => {
    return value >= min && value <= max;
};

const validateEasyRange = createRangeValidator(1)(100);
const validateHardRange = createRangeValidator(1)(1000);

// Пример мемоизации
const memoize = (fn) => {
    const cache = new Map();
    return function(...args) {
        const key = JSON.stringify(args);
        if (cache.has(key)) {
            return cache.get(key);
        }
        const result = fn.apply(this, args);
        cache.set(key, result);
        return result;
    };
};

// Мемоизированная функция для вычисления факториала (для демонстрации)
const factorial = memoize((n) => {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
});

// Пример использования замыканий для создания счетчиков
const createCounter = (initialValue = 0) => {
    let count = initialValue;
    
    return {
        increment: () => ++count,
        decrement: () => --count,
        getValue: () => count,
        reset: () => count = initialValue
    };
};

// Создаем счетчик игр
const gameCounter = createCounter();

console.log('Игра "Угадай число" загружена! 🎯');
console.log('Демонстрирует: функции, замыкания, область видимости, модульный паттерн');'''
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Проект: Игра "Угадай число"',
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
      body: Column(
        children: [
          // Прогресс бар
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Прогресс проекта',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${_stepCompleted.values.where((completed) => completed).length}/3',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: _stepCompleted.values.where((completed) => completed).length / 3,
                  backgroundColor: AppColors.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ],
            ),
          ),

          // Табы
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              tabs: _steps.asMap().entries.map((entry) {
                int index = entry.key;
                String step = entry.value;
                bool isCompleted = _stepCompleted[index] ?? false;
                
                return Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isCompleted)
                        Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 16,
                        )
                      else
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.textSecondary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: GoogleFonts.firaCode(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          step,
                          style: GoogleFonts.firaCode(
                            fontSize: 12,
                            color: isCompleted ? AppColors.success : AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
            ),
          ),

          // Контент
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStepContent(0, 'HTML структура', 'Создаем интерфейс игры с модальными окнами'),
                _buildStepContent(1, 'CSS стилизация', 'Добавляем анимации и адаптивный дизайн'),
                _buildStepContent(2, 'JavaScript логика', 'Реализуем игровую логику с функциями и замыканиями'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(int stepIndex, String title, String description) {
    bool isCompleted = _stepCompleted[stepIndex] ?? false;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок шага
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
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
                    Icon(
                      _getStepIcon(stepIndex),
                      color: AppColors.primary,
                      size: 24,
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
                    if (isCompleted)
                      Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
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
          const SizedBox(height: 16),

          // Инструкции для шага
          _buildStepInstructions(stepIndex),
          const SizedBox(height: 16),

          // Код
          Expanded(
            child: Container(
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
                        _getFileExtension(stepIndex),
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (!isCompleted)
                        TextButton.icon(
                          onPressed: () => _checkCode(stepIndex),
                          icon: Icon(
                            Icons.check,
                            color: AppColors.success,
                            size: 16,
                          ),
                          label: Text(
                            'Проверить',
                            style: GoogleFonts.firaCode(
                              color: AppColors.success,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _stepCode[stepIndex] ?? '',
                        style: GoogleFonts.firaCode(
                          fontSize: 12,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Кнопка завершения шага
          if (!isCompleted)
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _completeStep(stepIndex),
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
                    Icon(
                      Icons.check,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Завершить шаг',
                      style: GoogleFonts.firaCode(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.success,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Шаг завершен',
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepInstructions(int stepIndex) {
    List<String> instructions = [];
    
    switch (stepIndex) {
      case 0:
        instructions = [
          'Создайте HTML структуру с игровым интерфейсом',
          'Добавьте поле ввода, кнопки и область для обратной связи',
          'Создайте модальные окна для победы и выбора сложности',
          'Добавьте элементы для отображения статистики и истории',
        ];
        break;
      case 1:
        instructions = [
          'Стилизуйте игровой интерфейс с градиентами',
          'Добавьте анимации для модальных окон и обратной связи',
          'Создайте адаптивный дизайн для мобильных устройств',
          'Добавьте hover-эффекты для интерактивных элементов',
        ];
        break;
      case 2:
        instructions = [
          'Создайте игровой модуль с использованием IIFE и замыканий',
          'Реализуйте функции для генерации числа и проверки догадок',
          'Добавьте систему уровней сложности и подсказок',
          'Используйте localStorage для сохранения лучшего результата',
        ];
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
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
            'Что нужно сделать:',
            style: GoogleFonts.firaCode(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          ...instructions.map((instruction) => Padding(
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
                    instruction,
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

  IconData _getStepIcon(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return Icons.html;
      case 1:
        return Icons.palette;
      case 2:
        return Icons.psychology;
      default:
        return Icons.code;
    }
  }

  String _getFileExtension(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return 'index.html';
      case 1:
        return 'style.css';
      case 2:
        return 'script.js';
      default:
        return 'code';
    }
  }

  void _checkCode(int stepIndex) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Отличная работа! Код демонстрирует продвинутые концепции JavaScript.',
          style: GoogleFonts.firaCode(),
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _completeStep(int stepIndex) {
    setState(() {
      _stepCompleted[stepIndex] = true;
    });

    bool allCompleted = _stepCompleted.values.every((completed) => completed);
    
    if (allCompleted && !_isCompleted) {
      _isCompleted = true;
      _showProjectCompletionDialog();
    } else {
      if (stepIndex < 2) {
        _tabController.animateTo(stepIndex + 1);
      }
    }
  }

  void _showProjectCompletionDialog() {
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
                  Icons.emoji_events,
                  color: AppColors.success,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Проект завершен! 🎯',
                style: GoogleFonts.firaCode(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Поздравляем! Вы создали интерактивную игру!\n\nВы изучили:\n• Функции и их типы\n• Замыкания и область видимости\n• Модульный паттерн (IIFE)\n• Мемоизацию и каррирование\n• Управление состоянием\n\n+50 XP за завершение проекта!',
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