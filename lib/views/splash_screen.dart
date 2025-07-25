import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/views/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: kdarkColor,
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset(
              'Assets/Islamic Shape.json',
              height: 200,
              width: 200,
            ),
          ),
          Text(
            'Quran Plus',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppins',
              color: Colors.white,
            ),
          ).animate(delay: 1500.ms).fade(curve: Curves.easeIn)
        ],
      ),
      splashIconSize: MediaQuery.of(context).size.height * 0.5,
      nextScreen: HomeScreen(),
      duration: 3300,
    );
  }
}
