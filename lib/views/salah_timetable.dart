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
  late PrayerCubit _prayerCubit;

  @override
  void initState() {
    super.initState();
    _prayerCubit = PrayerCubit();
    _prayerCubit.fetchPrayerTimes('cairo', DateFormat('dd-MM-yyy').format(dt));
  }

  @override
  void dispose() {
    _prayerCubit.close();
    super.dispose();
  }

  String getCurrentDate() {
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _prayerCubit,
      child: BlocBuilder<PrayerCubit, PrayerState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Image.asset('Assets/images/1789.jpg'),
                    Expanded(child: Container(color: Color(0xff141E1F))),
                  ],
                ),
                ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100, width: double.infinity),
                    Center(
                      child: Text(
                        'مواقيت الصلاة',
                        style: TextStyle(fontSize: 42),
                      ),
                    ),

                    Center(
                      child: Text(
                        'حسب التوقيت المحلي لمدينة القاهرة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 32,
                      ),
                      child: Container(
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
                                  _prayerCubit.fetchPrayerTimes(
                                    "cairo",
                                    DateFormat('dd-MM-yyyy').format(dt),
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
                                  _prayerCubit.fetchPrayerTimes(
                                    "cairo",
                                    DateFormat('dd-MM-yyyy').format(dt),
                                  );
                                });
                              },
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white),
                        onSaved: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              // dt = DateTime.parse(newValue);
                              _prayerCubit.fetchPrayerTimes(
                                newValue,
                                DateFormat('dd-MM-yyyy').format(dt),
                              );
                            });
                          } else
                            setState(() {
                              dt = DateTime.now();
                              _prayerCubit.fetchPrayerTimes(
                                "cairo",
                                DateFormat('dd-MM-yyyy').format(dt),
                              );
                            });
                        },
                        // controller: TextEditingController(text: dt.toString()),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              dt = DateTime.parse(value);
                              _prayerCubit.fetchPrayerTimes(
                                value,
                                DateFormat('dd-MM-yyyy').format(dt),
                              );
                            });
                          } else
                            setState(() {
                              dt = DateTime.now();
                              _prayerCubit.fetchPrayerTimes(
                                "cairo",
                                DateFormat('dd-MM-yyyy').format(dt),
                              );
                            });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل مدينة';
                          }
                          return null;
                        },
                        cursorColor: Colors.white,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),

                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 24,
                          ),
                          labelText: 'ابحث عن مدينة',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          focusColor: Colors.white,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    // : to do
                    BlocBuilder<PrayerCubit, PrayerState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 24,
                          ),
                          child: Builder(
                            builder: (context) {
                              if (state is PrayerLoaded) {
                                final currentDay = state.prayerWeek.days
                                    .firstWhere(
                                      (day) =>
                                          day.date ==
                                          DateFormat('dd-MM-yyyy').format(dt),
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
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
