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
  late String? city = 'مكة المكرمة';
  late TextEditingController _cityController;
  GlobalKey<FormState> formState = GlobalKey();

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    _prayerCubit = PrayerCubit();
    _prayerCubit.fetchPrayerTimes(
      city ?? 'مكة المكرمة',
      DateFormat('dd-MM-yyy').format(dt),
    );
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
                      padding: const EdgeInsets.only(top: 32),
                      child: Center(
                        child: Text(
                          'مواقيت الصلاة',
                          style: TextStyle(fontSize: 42),
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
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.053,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' حسب التوقيت المحلي لمدينة',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,

                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 80, width: double.infinity),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 36,
                      ),
                      child: Container(
                        height: 42,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
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
                        child: TextFormField(
                          controller: _cityController,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white),
                          onFieldSubmitted: (value) {
                            if (formState.currentState!.validate()) {
                              setState(() {
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
                              return 'من فضلك ادخل مدينة';
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
