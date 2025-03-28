import 'package:devup/Controllers/ai_controller.dart';
import 'package:devup/Controllers/app_state_controller.dart';
import 'package:devup/Controllers/gamification_controller.dart';
import 'package:devup/Data/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("App starting: initializing services");

  await AppServices.init();

  print("App: Services initialized, setting up controllers");

  Get.put(GamificationController());
  Get.put(AIController());
  Get.put(AppStateController());

  print("App: All controllers initialized, starting app");

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevUp',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF5B5FEF),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF5B5FEF),
          secondary: Color(0xFF00C9B1),
          tertiary: Color(0xFFFF6B6B),
          surface: Color(0xFFF8F9FA),
          background: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF5B5FEF),
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(color: Color(0xFF2D3142)),
          headlineMedium: TextStyle(color: Color(0xFF2D3142)),
          bodyLarge: TextStyle(color: Color(0xFF2D3142)),
          bodyMedium: TextStyle(color: Color(0xFF2D3142)),
        ),
        fontFamily: 'Montserrat',
      ),
      home: SplashScreen(),
    );
  }
}
