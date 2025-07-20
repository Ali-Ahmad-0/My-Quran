import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/constants/lists.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/views/salah_timetable.dart';
import 'package:quran/widgets/surahListItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  late String currentTime;
  bool isDark = false;

  HijriCalendar hejri = HijriCalendar.now();

  DateTime dt = DateTime.now();
  bool isSelected = true;
  bool isSurah = true;
  Future<void> _getIsDark() async {
    final prfs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prfs.getBool('isDark') ?? false;
    });
  }

  Future<bool> _setDarkMode() async {
    final prfs = await SharedPreferences.getInstance();
    setState(() {
      isDark = !isDark;
    });
    return prfs.setBool('isDark', isDark);
  }

  @override
  void initState() {
    super.initState();
    currentTime = _getCurrentTime();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        currentTime = _getCurrentTime();
      });
    });
    _getIsDark();
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
      backgroundColor: isDark ? kdarkColor : ksecondaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Container(
              height: 300,
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
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : kdarkColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      SizedBox(height: 5),

                      SizedBox(height: 5),
                      Text(
                        '$currentTime',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : kdarkColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        hejri.toFormat('dd MMMM yyyy'),

                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : kdarkColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${dt.day.toString()} -  ${dt.month.toString()} - ${dt.year.toString()}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : kdarkColor,
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
                            color: kbackgroundColor,
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
                                'مواقيت الصلاة',
                                style: TextStyle(
                                  color: ksecondaryBackgroundColor,
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
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {},
                        child: Container(
                          height: 70,
                          width: 160,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? ksecondaryBackgroundColor
                                  : kdarkColor,
                              width: 1,
                            ),
                            color: isDark
                                ? ksecondaryBackgroundColor
                                : kdarkColor,
                            borderRadius: BorderRadiusDirectional.circular(20),
                          ),
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.arrow_back_ios,
                                color: isDark
                                    ? kdarkColor
                                    : ksecondaryBackgroundColor,
                              ),
                              title: Text(
                                'قرأتها مؤخرا ',
                                style: TextStyle(
                                  color: isDark
                                      ? kdarkColor
                                      : ksecondaryBackgroundColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'times',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              isDark ? Icons.light_mode_sharp : Icons.dark_mode,
                              size: 24,
                              color: isDark
                                  ? ksecondaryBackgroundColor
                                  : kdarkColor,
                            ),
                            onPressed: _setDarkMode,
                          ),
                        ),
                      ),
                      Image.asset(
                        (dt.hour > 19 || dt.hour < 5)
                            ? 'Assets/images/—Pngtree—hand drawn cartoon praying ramadan_5351151 1.png'
                            : 'Assets/images/image 4.png',
                        height: 200,
                        width: 200,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
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
                          border: Border.all(
                            color: isDark
                                ? ksecondaryBackgroundColor
                                : kdarkColor,
                            width: 1,
                          ),
                          color: isSelected
                              ? isDark
                                    ? ksecondaryBackgroundColor
                                    : kbackgroundColor
                              : isDark
                              ? kdarkColor
                              : ksecondaryBackgroundColor,
                          borderRadius: BorderRadiusDirectional.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'السور',
                            style: TextStyle(
                              color: isSelected
                                  ? isDark
                                        ? kdarkColor
                                        : ksecondaryBackgroundColor
                                  : isDark
                                  ? ksecondaryBackgroundColor
                                  : kdarkColor,
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
                        border: Border.all(
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : kdarkColor,
                          width: 1,
                        ),
                        color: isSelected
                            ? isDark
                                  ? kdarkColor
                                  : ksecondaryBackgroundColor
                            : isDark
                            ? ksecondaryBackgroundColor
                            : kbackgroundColor,
                        borderRadius: BorderRadiusDirectional.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'الاذكار',
                          style: TextStyle(
                            color: isSelected
                                ? isDark
                                      ? ksecondaryBackgroundColor
                                      : kdarkColor
                                : isDark
                                ? kdarkColor
                                : ksecondaryBackgroundColor,
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
                    isDark,
                    Surahs[index].startPage!,
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
      ),
    );
  }
}
