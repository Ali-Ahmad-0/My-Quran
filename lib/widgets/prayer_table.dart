import 'package:flutter/material.dart';
import 'package:quran/models/prayer_day.dart';

class PrayerTable extends StatelessWidget {
  final PrayerDay prayerDay;
  const PrayerTable({super.key, required this.prayerDay});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ListTile(
          leading: Text(
            'الفجر',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'amiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            prayerDay.fajr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'الشروق',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'amiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            prayerDay.shurooq,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'الظهر',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'amiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            prayerDay.dhuhr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'العصر',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'amiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            prayerDay.asr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'المغرب',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'amiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            prayerDay.maghrib,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'العشاء',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'amiri',
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            prayerDay.isha,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
