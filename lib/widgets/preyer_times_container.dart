import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/views/salah_timetable.dart';

class PreyerTimesContainer extends StatelessWidget {
  const PreyerTimesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalahTimetable()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kbackgroundColor,
          borderRadius: BorderRadiusDirectional.circular(7),
        ),

        height: 32.h,
        width: 160,
        child: Center(
          child: Text(
            'مواقيت الصلاة',
            style: TextStyle(
              color: ksecondaryBackgroundColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'poppins',
            ),
          ),
        ),
      ),
    );
  }
}
