import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Data/services/data_service.dart';
import '../Data/models/user_model.dart';
import '../Data/models/course_model.dart';
import '../Data/models/task_model.dart';

// Расширения для быстрого доступа к сервисам и данным
extension AppExtensions on BuildContext {
  // Быстрый доступ к DataService
  DataService get dataService => DataService.to;
  
  // Быстрый доступ к текущему пользователю
  User get currentUser => DataService.to.currentUser;
  
  // Быстрый доступ к списку курсов
  List<Course> get courses => DataService.to.courses;
  
  // Быстрый доступ к списку задач
  List<Task> get tasks => DataService.to.tasks;
  
  // Получить размер экрана
  Size get screenSize => MediaQuery.of(this).size;
  
  // Получить высоту экрана
  double get screenHeight => MediaQuery.of(this).size.height;
  
  // Получить ширину экрана
  double get screenWidth => MediaQuery.of(this).size.width;
  
  // Получить текущую тему
  ThemeData get theme => Theme.of(this);
  
  // Получить цвет основной темы
  Color get primaryColor => Theme.of(this).primaryColor;
  
  // Проверка, темная ли тема
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  // Быстрый доступ к текстовым стилям
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  // Отображение snackbar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
  
  // Отображение диалога
  Future<T?> showAppDialog<T>({
    required String title, 
    required String message, 
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm, 
    VoidCallback? onCancel,
  }) {
    return showDialog<T>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onCancel?.call();
              },
              child: Text(cancelText),
            ),
          if (confirmText != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text(confirmText),
            ),
        ],
      ),
    );
  }
} 