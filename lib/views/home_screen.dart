import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/constants/lists.dart';
import 'package:quran/models/prayer_day.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/views/salah_timetable.dart';
import 'package:quran/widgets/surahListItem.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  late String currentTime;

  HijriCalendar hejri = HijriCalendar.now();

  DateTime dt = DateTime.now();
  bool isSelected = true;
  bool isSurah = true;

  @override
  void initState() {
    super.initState();
    currentTime = _getCurrentTime();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        currentTime = _getCurrentTime();
      });
    });
  }

  List<Surah_item> Surahs = surahsList
      .map((e) => Surah_item.fromMap(e))
      .toList();

  String _getCurrentTime() {
    final now = DateTime.now();
    final hours = now.hour.toString().padLeft(2, '0');
    final minutes = now.minute.toString().padLeft(2, '0');
    final seconds = now.second.toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    timer.cancel(); // important to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: 280,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'My Quran',
                      style: TextStyle(
                        fontSize: 30,
                        color: kbuttonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Read the Quran easily',
                      style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '$currentTime',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      hejri.toFormat('dd MMMM yyyy'),

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${dt.day.toString()} -  ${dt.month.toString()} - ${dt.year.toString()}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                      ),
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SalahTimetable(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: kbuttonColor,
                          borderRadius: BorderRadiusDirectional.circular(7),
                        ),

                        height: 35,
                        width: 160,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 7,
                            ),
                            child: Text(
                              'الصلاة',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Image.asset(
                  'Assets/images/image 4.png',
                  height: 200,
                  width: 200,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        isSelected = true;
                        isSurah = true;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: 75,
                      decoration: BoxDecoration(
                        border: Border.all(color: kbuttonColor, width: 1),
                        color: isSelected ? kbuttonColor : Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'السور',
                          style: TextStyle(
                            color: isSelected ? Colors.white : kbuttonColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'amiri',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      isSelected = false;
                      isSurah = false;
                    });
                  },
                  child: Container(
                    height: 35,
                    width: 75,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      color: isSelected ? Colors.white : kbuttonColor,
                      borderRadius: BorderRadiusDirectional.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'الاذكار',
                        style: TextStyle(
                          color: isSelected ? kbuttonColor : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'amiri',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: isSurah ? Surahs.length : athkarMap.length,

              itemBuilder: (context, index) {
                return Surah_list_item(
                  isSurah: isSurah,
                  isSurah ? Surahs[index].numberOfAyahs.toString() : '',
                  isSurah
                      ? Surahs[index].name.toString()
                      : athkarMap.keys.toList()[index].toString(),
                  isSurah ? Surahs[index].revelationType.toString() : '',
                  (index + 1).toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
