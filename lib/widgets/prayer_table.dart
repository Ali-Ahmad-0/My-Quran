import 'package:flutter/material.dart';

class PrayerTable extends StatelessWidget {
  const PrayerTable({super.key});

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
            '04:18',
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
            '06:05',
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
            '01:00',
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
            '04:33',
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
            '08:12',
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
            '09:33',
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
