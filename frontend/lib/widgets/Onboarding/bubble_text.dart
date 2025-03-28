import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BubbleText extends StatelessWidget {
  final String bubbleText;
  final double width;
  final double height;
  final List<Color> gradient;

  const BubbleText({
    Key? key,
    required this.bubbleText,
    required this.width,
    required this.height,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      child: Center(
        child: Text(
          bubbleText,
          textAlign: TextAlign.center,
          style: GoogleFonts.firaCode(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 