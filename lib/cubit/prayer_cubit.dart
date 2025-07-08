import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran/models/prayer_week.dart';
import 'package:quran/services/prayer_times_service.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial());

  Future<void> fetchPrayerTimes(String city, String date) async {

    try {
      final prayerWeek = await GetPrayerTimesService().getPrayerTimes(city, date);
      emit(PrayerLoaded(prayerWeek));
    } catch (e) {
      emit(PrayerError('Error: ${e.toString()}'));
    }
  }
}
