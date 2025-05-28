import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Data/models.dart';
import '../Constants/app_config.dart';

class AuthService {
  late Dio _dio;
  
  AuthService() {
    if (!AppConfig.MOCK_MODE) {
      _dio = Dio(BaseOptions(
        baseUrl: AppConfig.backendUrl,
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ));
      
      // Добавляем interceptor для логирования
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj),
      ));
    }
  }

  // Вход в систему
  Future<JwtResponse> login(String email, String password) async {
    if (AppConfig.MOCK_MODE) {
      // Мок-режим: симулируем успешный вход
      if (AppConfig.DEBUG_MODE) {
        print('🔧 MOCK MODE: Simulating login for $email');
      }
      await Future.delayed(Duration(milliseconds: 500)); // Имитация задержки сети
      
      final mockResponse = JwtResponse(
        accessToken: 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        type: 'Bearer',
        expiresIn: 3600,
      );
      
      await _saveTokens(mockResponse);
      return mockResponse;
    }
    
    // Реальный режим с бэкендом
    try {
      final authRequest = AuthRequest(
        username: email,
        password: password,
      );

      final response = await _dio.post(
        AppConfig.authLoginEndpoint,
        data: authRequest.toJson(),
      );

      if (response.statusCode == 200) {
        final jwtResponse = JwtResponse.fromJson(response.data);
        await _saveTokens(jwtResponse);
        return jwtResponse;
      } else {
        throw ApiError(
          message: 'Ошибка авторизации',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ApiError(message: 'Неверный email или пароль');
      } else if (e.response?.statusCode == 400) {
        throw ApiError(message: 'Неверные данные для входа');
      } else {
        throw ApiError(message: 'Ошибка сети. Проверьте подключение к интернету');
      }
    } catch (e) {
      throw ApiError(message: 'Произошла неожиданная ошибка');
    }
  }

  // Регистрация
  Future<void> register(String username, String email, String password) async {
    if (AppConfig.MOCK_MODE) {
      // Мок-режим: симулируем успешную регистрацию
      if (AppConfig.DEBUG_MODE) {
        print('🔧 MOCK MODE: Simulating registration for $email');
      }
      await Future.delayed(Duration(milliseconds: 500)); // Имитация задержки сети
      return; // Успешная регистрация
    }
    
    // Реальный режим с бэкендом
    try {
      final registerRequest = RegisterRequest(
        username: username,
        email: email,
        password: password,
      );

      final response = await _dio.post(
        AppConfig.userCreateEndpoint,
        data: registerRequest.toJson(),
      );

      if (response.statusCode != 200) {
        throw ApiError(
          message: 'Ошибка регистрации',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ApiError(message: 'Неверные данные для регистрации');
      } else if (e.response?.statusCode == 409) {
        throw ApiError(message: 'Пользователь с таким email уже существует');
      } else {
        throw ApiError(message: 'Ошибка сети. Проверьте подключение к интернету');
      }
    } catch (e) {
      throw ApiError(message: 'Произошла неожиданная ошибка');
    }
  }

  // Выход из системы
  Future<void> logout() async {
    if (AppConfig.MOCK_MODE) {
      // Мок-режим: просто очищаем токены
      if (AppConfig.DEBUG_MODE) {
        print('🔧 MOCK MODE: Simulating logout');
      }
      await _clearTokens();
      return;
    }
    
    // Реальный режим с бэкендом
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        await _dio.post(
          AppConfig.authLogoutEndpoint,
          data: {'refreshToken': refreshToken},
        );
      }
    } catch (e) {
      print('Ошибка при выходе: $e');
    } finally {
      await _clearTokens();
    }
  }

  // Сохранение токенов
  Future<void> _saveTokens(JwtResponse jwtResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', jwtResponse.accessToken);
    await prefs.setString('refresh_token', jwtResponse.refreshToken);
    await prefs.setBool('is_logged_in', true);
  }

  // Получение access токена
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Получение refresh токена
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  // Проверка авторизации
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  // Очистка токенов
  Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.setBool('is_logged_in', false);
  }
} 