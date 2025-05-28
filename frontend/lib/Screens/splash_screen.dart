import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:devup/Constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'Auth/login_screen.dart';
import 'Dashboard/dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  static const int splashDurationSeconds = 4; // Длительность splash screen в секундах
  
  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset("assets/videos/Welcome_Gekko_V10.mp4")
          ..initialize().then((_) {
            setState(() {});
            _controller.play();
          });

    // Переходим к следующему экрану через заданное время
    Future.delayed(Duration(seconds: splashDurationSeconds), () {
      if (mounted) {
        if (AppConfig.SKIP_AUTH) {
          // Пропускаем авторизацию и идем сразу на Dashboard
          if (AppConfig.DEBUG_MODE) {
            print('🔧 SKIP_AUTH: Going directly to Dashboard');
          }
          Get.offAll(() => Dashboard());
        } else {
          // Обычный переход на экран входа
          if (AppConfig.DEBUG_MODE) {
            print('🔧 Normal flow: Going to LoginScreen');
          }
          Get.offAll(() => LoginScreen());
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final Shader linearGradient = LinearGradient(
    begin: FractionalOffset.topCenter,
    colors: <Color>[AppColors.primary, AppColors.secondary],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 30.0, 40.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: AppColors.background,
            position: "topLeft",
          ),
          Column(
            children: [
              const SizedBox(height: 180), // отступ сверху
              Center(
                child: _controller.value.isInitialized
                    ? SizedBox(
                        width: 250, // увеличенный размер
                        height: 250,
                        child: VideoPlayer(_controller),
                      )
                    : const SizedBox.shrink(), // ничего не показываем
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Dev',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Up',
                      style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Level Up Your Coding Skills',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
