import 'package:flutter/material.dart';

class SurahContent extends StatelessWidget {
  const SurahContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [SizedBox(height: 100), Image.asset('Assets/images/1.png')],
      ),
    );
  }
}
