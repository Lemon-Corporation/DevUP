import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Values/values.dart';

class FormValidationProject extends StatefulWidget {
  const FormValidationProject({Key? key}) : super(key: key);

  @override
  State<FormValidationProject> createState() => _FormValidationProjectState();
}

class _FormValidationProjectState extends State<FormValidationProject>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isCompleted = false;

  final List<String> _steps = [
    'HTML структура',
    'CSS стилизация',
    'JavaScript валидация',
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
    <title>Форма регистрации</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Регистрация пользователя</h1>
        <form id="registrationForm">
            <div class="form-group">
                <label for="username">Имя пользователя:</label>
                <input type="text" id="username" name="username" required>
                <span class="error" id="usernameError"></span>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <span class="error" id="emailError"></span>
            </div>
            
            <div class="form-group">
                <label for="password">Пароль:</label>
                <input type="password" id="password" name="password" required>
                <span class="error" id="passwordError"></span>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Подтвердите пароль:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <span class="error" id="confirmPasswordError"></span>
            </div>
            
            <div class="form-group">
                <label for="age">Возраст:</label>
                <input type="number" id="age" name="age" min="13" max="120" required>
                <span class="error" id="ageError"></span>
            </div>
            
            <button type="submit">Зарегистрироваться</button>
        </form>
        
        <div id="successMessage" class="success hidden">
            Регистрация прошла успешно!
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
    font-family: 'Arial', sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

.container {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    width: 100%;
    max-width: 400px;
}

h1 {
    text-align: center;
    color: #333;
    margin-bottom: 2rem;
    font-size: 1.8rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

label {
    display: block;
    margin-bottom: 0.5rem;
    color: #555;
    font-weight: bold;
}

input {
    width: 100%;
    padding: 0.75rem;
    border: 2px solid #ddd;
    border-radius: 5px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
}

input:focus {
    outline: none;
    border-color: #667eea;
}

input.valid {
    border-color: #28a745;
}

input.invalid {
    border-color: #dc3545;
}

.error {
    display: block;
    color: #dc3545;
    font-size: 0.875rem;
    margin-top: 0.25rem;
    min-height: 1.2rem;
}

button {
    width: 100%;
    padding: 0.75rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    font-weight: bold;
    cursor: pointer;
    transition: transform 0.2s ease;
}

button:hover {
    transform: translateY(-2px);
}

button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none;
}

.success {
    background: #d4edda;
    color: #155724;
    padding: 1rem;
    border-radius: 5px;
    text-align: center;
    margin-top: 1rem;
    border: 1px solid #c3e6cb;
}

.hidden {
    display: none;
}''',
    2: r'''// script.js
// Получаем элементы формы
const form = document.getElementById('registrationForm');
const usernameInput = document.getElementById('username');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('confirmPassword');
const ageInput = document.getElementById('age');
const successMessage = document.getElementById('successMessage');

// Функция для отображения ошибок
function showError(inputElement, message) {
    const errorElement = document.getElementById(inputElement.id + 'Error');
    errorElement.textContent = message;
    inputElement.classList.add('invalid');
    inputElement.classList.remove('valid');
}

// Функция для отображения успеха
function showSuccess(inputElement) {
    const errorElement = document.getElementById(inputElement.id + 'Error');
    errorElement.textContent = '';
    inputElement.classList.add('valid');
    inputElement.classList.remove('invalid');
}

// Валидация имени пользователя
function validateUsername(username) {
    // Проверяем длину (от 3 до 20 символов)
    if (username.length < 3) {
        return 'Имя пользователя должно содержать минимум 3 символа';
    }
    
    if (username.length > 20) {
        return 'Имя пользователя не должно превышать 20 символов';
    }
    
    // Проверяем на допустимые символы (буквы, цифры, подчеркивание)
    const usernameRegex = /^[a-zA-Zа-яА-Я0-9_]+$/;
    if (!usernameRegex.test(username)) {
        return 'Имя может содержать только буквы, цифры и подчеркивание';
    }
    
    return null; // Нет ошибок
}

// Валидация email
function validateEmail(email) {
    // Простая проверка формата email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (!emailRegex.test(email)) {
        return 'Введите корректный email адрес';
    }
    
    return null;
}

// Валидация пароля
function validatePassword(password) {
    if (password.length < 6) {
        return 'Пароль должен содержать минимум 6 символов';
    }
    
    // Проверяем наличие цифры
    if (!/\d/.test(password)) {
        return 'Пароль должен содержать хотя бы одну цифру';
    }
    
    // Проверяем наличие заглавной буквы
    if (!/[A-ZА-Я]/.test(password)) {
        return 'Пароль должен содержать хотя бы одну заглавную букву';
    }
    
    return null;
}

// Валидация подтверждения пароля
function validateConfirmPassword(password, confirmPassword) {
    if (password !== confirmPassword) {
        return 'Пароли не совпадают';
    }
    
    return null;
}

// Валидация возраста
function validateAge(age) {
    const ageNumber = parseInt(age);
    
    if (isNaN(ageNumber)) {
        return 'Введите корректный возраст';
    }
    
    if (ageNumber < 13) {
        return 'Возраст должен быть не менее 13 лет';
    }
    
    if (ageNumber > 120) {
        return 'Введите реальный возраст';
    }
    
    return null;
}

// Добавляем обработчики событий для валидации в реальном времени
usernameInput.addEventListener('input', function() {
    const error = validateUsername(this.value);
    if (error) {
        showError(this, error);
    } else {
        showSuccess(this);
    }
});

// … (далее без изменений)
'''  };

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
          'Проект: Форма валидации',
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
          // … остальная верстка без изменений
        ],
      ),
    );
  }
}
