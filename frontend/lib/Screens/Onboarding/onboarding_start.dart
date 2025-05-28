import 'dart:math' as math;

import 'package:devup/Screens/Onboarding/onboarding_carousel.dart';
import 'package:devup/Utils/utils.dart';
import 'package:devup/Values/values.dart';
import '../../Utils/utils.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';
import 'package:devup/widgets/Onboarding/background_image.dart';
import 'package:devup/widgets/Onboarding/bubble_text.dart';
import 'package:devup/widgets/Shapes/background_hexagon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingStart extends StatelessWidget {
  List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Добро пожаловать в DevUp!",
      "description":
          "Приложение для подготовки к техническим собеседованиям в игровой форме",
      "image": "assets/placeholder.png",
    },
    {
      "title": "Выбери свой путь",
      "description":
          "Frontend, Backend или Full-Stack - выбери направление и уровень сложности",
      "image": "assets/placeholder.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DarkRadialBackground(
          color: Colors.white,
          position: "topLeft",
        ),
        Positioned(
            top: Utils.screenHeight,
            left: 0,
            child: Transform.rotate(
                angle: -math.pi / 2,
                child: CustomPaint(painter: BackgroundHexagon()))),
        Positioned(
            top: Utils.screenHeight * 0.7,
            right: 100,
            child: BackgroundImage(
                scale: 1.0,
                image: "assets/placeholder.png",
                gradient: [Color(0xFF6200EE), Color(0xFF03DAC6)])),
        Positioned(
            top: Utils.screenHeight * 0.50,
            left: Utils.screenWidth * 0.12,
            child: BackgroundImage(
                scale: 0.5,
                image: "assets/placeholder.png",
                gradient: [Color(0xFF6200EE), Color(0xFF03DAC6)])),
        Positioned(
            top: Utils.screenHeight * 0.30,
            right: 70,
            child: BackgroundImage(
                scale: 0.4,
                image: "assets/placeholder.png",
                gradient: [Color(0xFF6200EE), Color(0xFF03DAC6)])),
        Positioned(
            top: Utils.screenHeight * 0.3,
            left: 20,
            child: BubbleText(
              bubbleText: "TypeScript",
              width: 150,
              height: 50,
              gradient: [Color(0xFF6200EE), Color(0xFF03DAC6)],
            )),
        Positioned(
            top: Utils.screenHeight * 0.6,
            right: 20,
            child: BubbleText(
              bubbleText: "React и JavaScript",
              width: 120,
              height: 50,
              gradient: [Color(0xFF6200EE), Color(0xFF03DAC6)],
            )),
        Positioned(
            top: Utils.screenHeight * 0.42,
            right: Utils.screenWidth * 0.3,
            child: BubbleText(
              bubbleText: "SQL и базы данных",
              width: 130,
              height: 50,
              gradient: [Color(0xFF6200EE), Color(0xFF03DAC6)],
            )),
        Positioned(
            bottom: 0,
            child: Container(
              width: Utils.screenWidth,
              height: Utils.screenHeight * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.9)
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text("Готовьтесь к\nсобеседованиям\nс DevUp",
                      style: GoogleFonts.firaCode(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          height: 1.3)),
                  SizedBox(height: 20),
                  Text(
                      "Прокачивайте навыки программирования, решайте задачи и проходите тесты в игровой форме",
                      style: GoogleFonts.firaCode(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 16,
                          height: 1.5)),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => OnboardingCarousel());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF6200EE),
                          ),
                          child: Text(
                            "Начать",
                            style: GoogleFonts.firaCode(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Text("Уже есть аккаунт?",
                          style: GoogleFonts.firaCode(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14)),
                    ],
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
