import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:quran/constants/colors.dart';
import 'package:quran/cubit/prayer_cubit.dart';
import 'package:quran/models/prayer_day.dart';
import 'package:quran/widgets/prayer_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SalahTimetable extends StatefulWidget {
  SalahTimetable({super.key});

  @override
  State<SalahTimetable> createState() => _SalahTimetableState();
}

class _SalahTimetableState extends State<SalahTimetable> {
  DateTime dt = DateTime.now();
  late PrayerCubit _prayerCubit;
  late String? city = 'مكة المكرمة';
  late TextEditingController _cityController;
  GlobalKey<FormState> formState = GlobalKey();
  Future<void> _getCity() async {
    final prfs = await SharedPreferences.getInstance();
    String? savedCity = prfs.getString('CityName');
    setState(() {
      city = savedCity ?? 'مكة المكرمة';
    });
    _prayerCubit.fetchPrayerTimes(city!, DateFormat('dd-MM-yyyy').format(dt));
  }

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    _prayerCubit = PrayerCubit();
    _getCity();
  }

  @override
  void dispose() {
    _cityController.dispose();

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
                    Image.asset(
                      'Assets/images/1789.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                    Expanded(child: Container(color: Color(0xff141E1F))),
                  ],
                ),
                ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          'مواقيت الصلاة',
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.black,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 36),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${city ?? "مكة المكرمة"}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: ktextColor,
                                fontFamily: 'poppins',
                              ),
                            ),
                            Text(
                              ' حسب التوقيت المحلي لمدينة',
                              style: TextStyle(
                                color: ktextColor,
                                fontSize: 17.sp,
                                fontFamily: 'poppins',

                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.123,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 34,
                      ),
                      child: Container(
                        height: 42,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dt = dt.add(Duration(days: -1));
                                  _prayerCubit.fetchPrayerTimes(
                                    city ?? 'مكة المكرمة',
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
                                    city ?? 'مكة المكرمة',
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
                      child: Form(
                        key: formState,
                        child: TextFormField(
                          controller: _cityController,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white),
                          onFieldSubmitted: (value) async {
                            if (formState.currentState!.validate()) {
                              final prfs =
                                  await SharedPreferences.getInstance();
                              await prfs.setString('CityName', value);
                              setState(() async {
                                city = value;
                                _prayerCubit.fetchPrayerTimes(
                                  city!,
                                  DateFormat('dd-MM-yyyy').format(dt),
                                );
                              });
                            }
                          },

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل اسم مدينة';
                            }
                            return null;
                          },
                          cursorColor: Colors.white,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),

                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 24,
                            ),
                            labelText: 'ابحث عن مدينة',
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'tajawal',
                              fontSize: 16,
                            ),
                            focusColor: Colors.white,
                            fillColor: Colors.white,
                          ),
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
                                return Skeletonizer(
                                  child: PrayerTable(
                                    prayerDay: PrayerDay(
                                      date: 'date',
                                      fajr: 'fajr',
                                      shurooq: 'shurooq',
                                      dhuhr: 'dhuhr',
                                      asr: 'asr',
                                      maghrib: 'maghrib',
                                      isha: 'isha',
                                    ),
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
