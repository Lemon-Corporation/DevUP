import 'package:get/get.dart';
import 'data_service.dart';

// Класс для инициализации всех сервисов приложения
class AppServices {
  // Инициализация всех сервисов
  static Future<void> init() async {
    // Регистрация DataService как синглтон
    await Get.putAsync<DataService>(() => DataService().init());
  }
  
  // Метод для инициализации моков и тестовых данных (для демо)
  static Future<void> initMockData() async {
    // Дополнительная инициализация тестовых данных, если потребуется
  }
} 