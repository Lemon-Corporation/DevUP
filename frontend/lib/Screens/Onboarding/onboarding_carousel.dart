import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devup/Screens/Dashboard/dashboard.dart';
import 'package:devup/Values/values.dart';
import 'package:devup/widgets/DarkBackground/darkRadialBackground.dart';

class OnboardingCarousel extends StatefulWidget {
  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Учитесь в игровой форме",
      description: "Решайте задачи, проходите тесты и анализируйте код, получая опыт и энергию за каждое выполненное задание.",
      image: "assets/onboarding1.png",
      icon: Icons.code,
    ),
    OnboardingPage(
      title: "Отслеживайте прогресс",
      description: "Следите за своим прогрессом по различным темам и направлениям программирования.",
      image: "assets/onboarding2.png",
      icon: Icons.trending_up,
    ),
    OnboardingPage(
      title: "Практикуйтесь в собеседованиях",
      description: "Проходите симуляции собеседований с AI-интервьюером и получайте обратную связь.",
      image: "assets/onboarding3.png",
      icon: Icons.person,
    ),
    OnboardingPage(
      title: "Выполняйте челленджи",
      description: "Ежедневные челленджи помогут вам поддерживать мотивацию и регулярно практиковаться.",
      image: "assets/onboarding4.png",
      icon: Icons.emoji_events,
    ),
  ];
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAll(() => Dashboard());
    }
  }
  
  void _skipToEnd() {
    Get.offAll(() => Dashboard());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DarkRadialBackground(
            color: Color(0xFF121212),
            position: "topLeft",
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildPage(_pages[index]);
                    },
                  ),
                ),
                _buildBottomControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFF6200EE).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              color: Color(0xFF6200EE),
              size: 60,
            ),
          ),
          SizedBox(height: 40),
          Text(
            page.title,
            style: GoogleFonts.firaCode(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            page.description,
            style: GoogleFonts.firaCode(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomControls() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => _buildDotIndicator(index),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage < _pages.length - 1)
                GestureDetector(
                  onTap: _skipToEnd,
                  child: Text(
                    "Пропустить",
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                )
              else
                SizedBox.shrink(),
              GestureDetector(
                onTap: _nextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFF6200EE),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    _currentPage < _pages.length - 1 ? "Далее" : "Начать",
                    style: GoogleFonts.firaCode(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildDotIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Color(0xFF6200EE) : Colors.white24,
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final IconData icon;
  
  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
  });
}
