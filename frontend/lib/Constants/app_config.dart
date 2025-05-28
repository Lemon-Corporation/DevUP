class AppConfig {
  // ===========================================
  // НАСТРОЙКИ ДЛЯ РАЗРАБОТКИ БЕЗ БЭКЕНДА
  // ===========================================
  
  /// Включить мок-режим (работа без бэкенда)
  /// true = работа без сервера, false = работа с реальным бэкендом
  static const bool MOCK_MODE = true;
  
  /// Пропустить авторизацию при запуске
  /// true = сразу переходить на Dashboard, false = показывать экран входа
  static const bool SKIP_AUTH = true;
  
  /// Показывать отладочную информацию
  static const bool DEBUG_MODE = true;
  
  // ===========================================
  // НАСТРОЙКИ БЭКЕНДА (когда MOCK_MODE = false)
  // ===========================================
  
  /// URL бэкенда для разработки
  static const String DEV_BACKEND_URL = 'http://localhost:8080';
  
  /// URL бэкенда для продакшена
  static const String PROD_BACKEND_URL = 'https://your-backend-domain.com';
  
  /// Текущий URL бэкенда
  static String get backendUrl => DEV_BACKEND_URL;
  
  // ===========================================
  // API ENDPOINTS
  // ===========================================
  
  /// API endpoints
  static const String authLoginEndpoint = '/api/v1/users/mobile/auth/login';
  static const String authLogoutEndpoint = '/api/v1/users/mobile/auth/logout';
  static const String authRefreshEndpoint = '/api/v1/users/mobile/auth/refresh';
  static const String userCreateEndpoint = '/api/v1/users/create';
  static const String userProfileEndpoint = '/api/v1/users/profile';
  
  // ===========================================
  // TIMEOUTS
  // ===========================================
  
  /// Timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  
  // ===========================================
  // ИНСТРУКЦИЯ ПО ПЕРЕКЛЮЧЕНИЮ РЕЖИМОВ
  // ===========================================
  
  /// Чтобы включить работу с бэкендом:
  /// 1. Установите MOCK_MODE = false
  /// 2. Установите SKIP_AUTH = false  
  /// 3. Убедитесь, что бэкенд запущен на DEV_BACKEND_URL
  /// 4. Перезапустите приложение
  
  /// Чтобы работать без бэкенда (текущий режим):
  /// 1. Установите MOCK_MODE = true
  /// 2. Установите SKIP_AUTH = true
  /// 3. Приложение будет работать с моковыми данными
} 