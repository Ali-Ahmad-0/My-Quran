import 'package:flutter/material.dart';
import 'package:quran/constants/lists.dart';

class SurahContent extends StatelessWidget {
  final int startPage;
  SurahContent({super.key, required this.startPage});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final portraitHeight = orientation == Orientation.portrait
        ? screenSize.height * 0.95
        : screenSize.height *
              3; // because in landscape, width = height of portrait
    final screenWidth = orientation == Orientation.landscape
        ? screenSize.width * 10
        : screenSize.width *
              .5; // because in landscape, width = height of portrait

    return Scaffold(
      body: PageView.builder(
        reverse: true,
        itemCount: pageImagePath.length,
        itemBuilder: (context, index) {
          return ListView(
            children: [
              //SizedBox(height: 12),
              Image.asset(
                'Assets/quran_image/${pageImagePath[index]}',
                fit: BoxFit.fill,
                height: portraitHeight,
                // width: screenWidth,
              ),
            ],
          );
        },
      ),
    );
  }
}
