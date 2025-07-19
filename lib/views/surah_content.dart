import 'package:flutter/material.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/constants/lists.dart';

class SurahContent extends StatelessWidget {
  final int startPage;
  final String surahName;
  SurahContent({super.key, required this.startPage, required this.surahName});
  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: startPage - 1);
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final portraitHeight = orientation == Orientation.portrait
        ? screenSize.height * 0.95
        : screenSize.height * 3;
    return Scaffold(
      body: PageView.builder(
        controller: _pageController ?? PageController(initialPage: 0),
        reverse: true,
        itemCount: pageImagePath.length,
        itemBuilder: (context, index) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  'Assets/quran_image/${pageImagePath[index]}',
                  fit: BoxFit.fill,
                  height: portraitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${index + 1} الصفحة',
                      style: TextStyle(
                        fontFamily: 'amiri',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ktextColor,
                      ),
                    ),
                    Text(
                      '$surahName',
                      style: TextStyle(
                        fontFamily: 'amiri',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ktextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
