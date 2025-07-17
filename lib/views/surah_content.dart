import 'package:flutter/material.dart';

class SurahContent extends StatelessWidget {
  SurahContent({super.key});
  final List<String> pages = [
    'Assets/images/1.png',
    'Assets/images/1.png',
    'Assets/images/1.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        reverse: true,
       itemCount: pages.length,
       itemBuilder: (context, index) {
        return Image.asset(pages[index]);
       },
      ),
    );
  }
}
