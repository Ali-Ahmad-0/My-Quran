import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quran/widgets/prayer_table.dart';

class SalahTimetable extends StatefulWidget {
  SalahTimetable({super.key});

  @override
  State<SalahTimetable> createState() => _SalahTimetableState();
}

class _SalahTimetableState extends State<SalahTimetable> {
  DateTime dt = DateTime.now();

  String getCurrentDate() {
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset('Assets/images/1789.jpg'),
              Expanded(child: Container(color: Color(0xff141E1F))),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100, width: double.infinity),
              Text('مواقيت الصلاة', style: TextStyle(fontSize: 42)),
              SizedBox(height: 180),
              Container(
                height: 50,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          dt = dt.add(Duration(days: -1));
                        });
                      },
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    Text(
                      getCurrentDate(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          dt = dt.add(Duration(days: 1));
                        });
                      },
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 24,
                ),
                child: PrayerTable(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
