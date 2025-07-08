import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran/cubit/prayer_cubit.dart';
import 'package:quran/models/prayer_day.dart';
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

  // @override
  // void initState() {
  //   BlocProvider.of<PrayerCubit>(
  //     context,
  //   ).fetchPrayerTimes('cairo', dt.toString());
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PrayerCubit()
            ..fetchPrayerTimes("cairo", DateFormat('MM-dd-yyyy').format(dt)),
      child: Scaffold(
        body: BlocBuilder<PrayerCubit, PrayerState>(
          builder: (context, state) {
            return Stack(
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
                                context.read<PrayerCubit>().fetchPrayerTimes(
                                  "cairo",
                                  DateFormat('MM-dd-yyyy').format(dt),
                                );
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
                                context.read<PrayerCubit>().fetchPrayerTimes(
                                  "cairo",
                                  DateFormat('MM-dd-yyyy').format(dt),
                                );
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
                      child: Builder(
                        builder: (context) {
                          if (state is PrayerLoaded) {
                            // ابحث عن اليوم الحالي في القائمة
                            final currentDay = state.prayerWeek.days.firstWhere(
                              (day) =>
                                  day.date == DateFormat('yyyy-M-d').format(dt),
                              orElse: () => state.prayerWeek.days.first,
                            );

                            return PrayerTable(prayerDay: currentDay);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
