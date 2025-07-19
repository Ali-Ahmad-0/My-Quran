import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/constants/colors.dart'
    show
        kbackgroundColor,
        kbuttonColor,
        ksecondaryBackgroundColor,
        ksecondtextColor,
        ktextColor,
        kdarkColor;
import 'package:quran/views/athkar_screen.dart';
import 'package:quran/views/ayahs_screen.dart';
import 'package:quran/views/surah_content.dart';

class Surah_list_item extends StatelessWidget {
  String name, revType, nOfSurahs, number;
  bool isSurah, isDark;
  int startPage;
  Surah_list_item(
    this.isDark,
    this.startPage,
    this.nOfSurahs,
    this.name,
    this.revType,
    this.number, {
    required this.isSurah,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => isSurah
                  ? SurahContent(startPage: startPage, surahName: name)
                  : AthkarScreen(keys: name, isDark: isDark),
            ),
          );
        },

        child: Container(
          height: 70,
          child: Row(
            children: [
              Container(
                width: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark ? Colors.grey : kbackgroundColor,
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 335,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isDark
                      ? kdarkColor // match home screen dark background
                      : ksecondaryBackgroundColor, // match home screen light background
                  borderRadius: BorderRadius.circular(12), // optional
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.white.withOpacity(
                              0.2,
                            ) // subtle light shadow for dark mode
                          : Colors.black.withOpacity(
                              0.3,
                            ), // subtle dark shadow for light mode
                      spreadRadius: 3, // how much the shadow spreads
                      blurRadius: 8, // how soft the shadow is
                      offset: Offset(1, 4), // shadow position: x, y
                    ),
                  ],
                ),
                child: ListTile(
                  leading: isSurah
                      ? Leading(number: number, isDark: isDark)
                      : Icon(
                          Icons.arrow_back_ios_outlined,
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : ktextColor,
                        ),
                  title: Container(
                    width: 10,
                    child: Text(
                      revType,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: isDark ? ksecondaryBackgroundColor : ktextColor,
                      ),
                    ),
                  ),
                  subtitle: isSurah
                      ? Text(
                          'عدد الاّيات : $nOfSurahs ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: isDark
                                ? ksecondaryBackgroundColor
                                : ktextColor,
                          ),
                        )
                      : SizedBox(),
                  trailing: Hero(
                    tag: 1,
                    child: Text(
                      '$name',
                      style: TextStyle(
                        color: isDark ? ksecondaryBackgroundColor : ktextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Amiri',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Leading extends StatelessWidget {
  final bool isDark;
  const Leading({super.key, required this.number, required this.isDark});

  final String number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45, // or whatever size your SVG is
      height: 45,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'Assets/images/muslim (1) 1.svg',
            height: 45,
            width: 45,
            fit: BoxFit.contain,
          ),
          Text(
            '$number',
            style: TextStyle(
              fontSize: 16, // Adjust as needed
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: isDark ? ksecondaryBackgroundColor : ktextColor,
            ),
          ),
        ],
      ),
    );
  }
}
