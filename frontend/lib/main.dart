import 'package:devup/Controllers/ai_controller.dart';
import 'package:devup/Controllers/app_state_controller.dart';
import 'package:devup/Controllers/gamification_controller.dart';
import 'package:devup/Data/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/Learning/course_detail_screen.dart';

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
      title: 'DevUP',
      theme: ThemeData(
        primaryColor: Color(0xFF5B5FEF),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: CourseDetailScreen(courseId: "javascript-course"),
    );
  }
}
