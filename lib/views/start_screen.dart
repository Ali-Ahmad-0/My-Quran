import 'package:flutter/material.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/views/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 160, width: double.infinity),
          Image.asset('Assets/images/quran.png', height: 200),
          SizedBox(height: 65),
          Text(
            'My Quran',
            style: TextStyle(
              color: ktextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 42),
          Text(
            'Read the Quran easily',
            style: TextStyle(
              color: ksecondtextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 160),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Container(
              height: 53,
              width: 180,
              decoration: BoxDecoration(
                color: kbuttonColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  'اقرأ الان',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
