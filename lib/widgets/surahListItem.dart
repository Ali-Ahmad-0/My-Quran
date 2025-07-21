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
import 'package:quran/widgets/item_Leading.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => isSurah
                  ? SurahContent(
                      startPage: startPage,
                      surahName: name,
                      isDark: isDark,
                    )
                  : AthkarScreen(keys: name, isDark: isDark),
            ),
          );
        },

        child: Container(
          height: 70,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      spreadRadius: 0.7, // how much the shadow spreads
                      blurRadius: 10, // how soft the shadow is
                      offset: Offset(-3, 3), // shadow position: x, y
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
                  trailing: Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
