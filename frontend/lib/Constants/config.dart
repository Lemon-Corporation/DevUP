class AppConfig {
  // Backend configuration
  static const String baseUrl = 'http://localhost:8080'; // Для локальной разработки
  // static const String baseUrl = 'http://192.168.1.100:8080'; // Для тестирования на реальном устройстве
  // static const String baseUrl = 'https://your-backend-domain.com'; // Для продакшена
  
  // API endpoints
  static const String authLoginEndpoint = '/api/v1/users/mobile/auth/login';
  static const String authLogoutEndpoint = '/api/v1/users/mobile/auth/logout';
  static const String authRefreshEndpoint = '/api/v1/users/mobile/auth/refresh';
  static const String userCreateEndpoint = '/api/v1/users/create';
  static const String userProfileEndpoint = '/api/v1/users/profile';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
} 