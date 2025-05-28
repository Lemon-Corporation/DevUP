import 'package:get/get.dart';
import '../Services/auth_service.dart';
import '../Data/models.dart';
import '../Screens/Dashboard/dashboard.dart';
import '../Screens/Auth/login_screen.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  
  // Состояния загрузки
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  
  // Для формы входа
  var emailController = ''.obs;
  var passwordController = ''.obs;
  var rememberMe = false.obs;
  var obscurePassword = true.obs;
  
  // Для формы регистрации
  var nameController = ''.obs;
  var registerEmailController = ''.obs;
  var registerPasswordController = ''.obs;
  var confirmPasswordController = ''.obs;
  var obscureConfirmPassword = true.obs;
  var agreeToTerms = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Проверка статуса авторизации при запуске
  void checkLoginStatus() async {
    try {
      isLoggedIn.value = await _authService.isLoggedIn();
    } catch (e) {
      print('Ошибка проверки статуса авторизации: $e');
    }
  }

  // Валидация email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Валидация пароля
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Вход в систему
  Future<void> login(String email, String password) async {
    if (isLoading.value) return;

    // Валидация
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Ошибка',
        'Заполните все поля',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Ошибка',
        'Введите корректный email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      await _authService.login(email, password);
      isLoggedIn.value = true;
      
      Get.snackbar(
        'Успех',
        'Вы успешно вошли в систему',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      
      // Переход на главный экран
      Get.offAll(() => Dashboard());
      
    } on ApiError catch (e) {
      Get.snackbar(
        'Ошибка входа',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } catch (e) {
      Get.snackbar(
        'Ошибка',
        'Произошла неожиданная ошибка',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Регистрация
  Future<void> register(String username, String email, String password, String confirmPassword) async {
    if (isLoading.value) return;

    // Валидация
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Ошибка',
        'Заполните все поля',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Ошибка',
        'Введите корректный email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    if (!isValidPassword(password)) {
      Get.snackbar(
        'Ошибка',
        'Пароль должен содержать минимум 6 символов',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Ошибка',
        'Пароли не совпадают',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    if (!agreeToTerms.value) {
      Get.snackbar(
        'Ошибка',
        'Необходимо согласиться с условиями использования',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      await _authService.register(username, email, password);
      
      Get.snackbar(
        'Успех',
        'Регистрация прошла успешно! Теперь вы можете войти в систему',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      
      // Переход на экран входа
      Get.off(() => LoginScreen());
      
    } on ApiError catch (e) {
      Get.snackbar(
        'Ошибка регистрации',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } catch (e) {
      Get.snackbar(
        'Ошибка',
        'Произошла неожиданная ошибка',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Выход из системы
  Future<void> logout() async {
    try {
      await _authService.logout();
      isLoggedIn.value = false;
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print('Ошибка при выходе: $e');
    }
  }

  // Переключение видимости пароля
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  // Переключение чекбоксов
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void toggleAgreeToTerms() {
    agreeToTerms.value = !agreeToTerms.value;
  }
} 