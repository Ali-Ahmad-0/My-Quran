import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/constants/colors.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Container(
        height: 75.h,

        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 7.w,

                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark ? Colors.grey : kbackgroundColor,
                ),
              ),
              Container(
                width: 300.w,
                height: 60.h,
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
                      offset: Offset(0, 3), // shadow position: x, y
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
                        fontSize: 16,
                        color: isDark ? ksecondaryBackgroundColor : ktextColor,
                        fontFamily: 'tajawal',
                      ),
                    ),
                  ),
                  subtitle: isSurah
                      ? Text(
                          'عدد الآيات : $nOfSurahs ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDark
                                ? ksecondaryBackgroundColor
                                : ktextColor,
                            fontFamily: 'tajawal',
                          ),
                        )
                      : SizedBox(),
                  trailing: Text(
                    '$name',
                    style: TextStyle(
                      color: isDark ? ksecondaryBackgroundColor : ktextColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'tajawal',
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
