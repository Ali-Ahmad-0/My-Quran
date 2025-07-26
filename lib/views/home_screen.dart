import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/constants/lists.dart';
import 'package:quran/models/surah_model.dart';
import 'package:quran/views/athkar_screen.dart';
import 'package:quran/views/surah_content.dart';
import 'package:quran/widgets/preyer_times_container.dart';
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
  int? latestpagenumber;
  String? surahName;

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

  Future<void> _getPageNumber() async {
    final prfs = await SharedPreferences.getInstance();
    setState(() {
      latestpagenumber = prfs.getInt('latestPageNumber') ?? 1;
      surahName = prfs.getString('surahName') ?? 'الفاتحة';
    });
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
    _getPageNumber();
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
        padding: const EdgeInsets.only(top: 8, right: 12, left: 12),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quran Plus',
                  style: TextStyle(
                    fontSize: 30,
                    color: isDark ? ksecondaryBackgroundColor : kdarkColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode_sharp : Icons.dark_mode,
                    size: 24,
                    color: isDark ? ksecondaryBackgroundColor : kdarkColor,
                  ),
                  onPressed: _setDarkMode,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      '$currentTime',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                        color: isDark ? ksecondaryBackgroundColor : kdarkColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      hejri.toFormat('dd MMMM yyyy'),

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                        color: isDark ? ksecondaryBackgroundColor : kdarkColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${dt.day.toString()} -  ${dt.month.toString()} - ${dt.year.toString()}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins',
                        color: isDark ? ksecondaryBackgroundColor : kdarkColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    PreyerTimesContainer(),

                    SizedBox(height: 20),
                  ],
                ),
                Image.asset(
                  (dt.hour > 19 || dt.hour < 5)
                      ? 'Assets/images/—Pngtree—hand drawn cartoon praying ramadan_5351151 1.png'
                      : 'Assets/images/image 4.png',
                  height: 180,
                  width: 190,
                ),
              ],
            ),

            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahContent(
                      startPage: latestpagenumber ?? 1,
                      surahName: surahName ?? 'الفاتحة',
                      isDark: isDark,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 80,

                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: kbackgroundColor),
                    color: isDark ? kbackgroundColor : kbackgroundColor,
                    borderRadius: BorderRadiusDirectional.circular(16),
                  ),
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 18),
                      leading: Icon(
                        Icons.arrow_back_ios,
                        color: isDark
                            ? ksecondaryBackgroundColor
                            : ksecondaryBackgroundColor,
                      ),
                      title: Text(
                        'قرأتها مؤخرا ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : ksecondaryBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'tajawal',
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'سورة $surahName - صفحة : $latestpagenumber',

                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? ksecondaryBackgroundColor
                              : ksecondaryBackgroundColor,
                          fontFamily: 'tajawal',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 45),
            Row(
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
                                  : kdarkColor
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
                            fontFamily: 'tajawal',
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
                        color: isDark ? ksecondaryBackgroundColor : kdarkColor,
                        width: 1,
                      ),
                      color: isSelected
                          ? isDark
                                ? kdarkColor
                                : ksecondaryBackgroundColor
                          : isDark
                          ? ksecondaryBackgroundColor
                          : kdarkColor,
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
                          fontFamily: 'tajawal',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: isSurah ? Surahs.length : athkarMap.length,

              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => isSurah
                            ? SurahContent(
                                startPage: Surahs[index].startPage!,
                                surahName: Surahs[index].name!,
                                isDark: isDark,
                              )
                            : AthkarScreen(
                                keys: athkarMap.keys.toList()[index].toString(),
                                isDark: isDark,
                              ),
                      ),
                    );
                    setState(() {
                      _getPageNumber();
                    });
                  },
                  child: Surah_list_item(
                    isDark,
                    Surahs[index].startPage!,
                    isSurah: isSurah,
                    isSurah ? Surahs[index].numberOfAyahs.toString() : '',
                    isSurah
                        ? Surahs[index].name.toString()
                        : athkarMap.keys.toList()[index].toString(),
                    isSurah ? Surahs[index].revelationType.toString() : '',
                    (index + 1).toString(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
