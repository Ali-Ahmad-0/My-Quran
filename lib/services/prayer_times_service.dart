import 'package:dio/dio.dart' show Dio;
import 'package:quran/models/prayer_week.dart';

class GetPrayerTimesService {
  Dio _dio = Dio();

  Future<PrayerWeek> getPrayerTimes(String city, String date) async {
    final String url = 'https://muslimsalat.com/$city/weekly/$date.json';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return PrayerWeek.fromJson(response.data);
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (e) {
      throw Exception('Failed to load prayer times on error: $e');
    }
  }
}
