import 'package:devup/Controllers/ai_controller.dart';
import 'package:devup/Controllers/app_state_controller.dart';
import 'package:devup/Controllers/gamification_controller.dart';
import 'package:devup/Controllers/auth_controller.dart';
import 'package:devup/Data/services/app_services.dart';
import 'package:devup/Screens/Auth/login_screen.dart';
import 'package:devup/Screens/Auth/register_screen.dart';
import 'package:devup/Screens/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("App starting: initializing services");

  // Инициализация сервисов и данных
  await AppServices.init();

  print("App: Services initialized, setting up controllers");

  // Инициализация контроллеров
  Get.put(GamificationController());
  Get.put(AIController());
  Get.put(AppStateController());
  Get.put(AuthController());

  print("App: All controllers initialized, starting app");

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevUp',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF5B5FEF), // Более мягкий фиолетовый
        colorScheme: ColorScheme.light(
          primary: Color(0xFF5B5FEF),
          secondary: Color(0xFF00C9B1), // Бирюзовый акцент
          tertiary: Color(0xFFFF6B6B), // Коралловый для акцентов
          surface: Color(0xFFF8F9FA), // Светло-серый для карточек
          background: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF5B5FEF),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: TextTheme(
          headlineLarge:
              TextStyle(color: Color(0xFF2D3142)), // headline1 → headlineLarge
          headlineMedium:
              TextStyle(color: Color(0xFF2D3142)), // headline2 → headlineMedium
          bodyLarge:
              TextStyle(color: Color(0xFF2D3142)), // bodyText1 → bodyLarge
          bodyMedium:
              TextStyle(color: Color(0xFF2D3142)), // bodyText2 → bodyMedium
        ),
        fontFamily: 'Montserrat', // Apple-подобный шрифт
      ),
      home: SplashScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/dashboard', page: () => Dashboard()),
      ],
    );
  }
}
