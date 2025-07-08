import 'prayer_day.dart';

class PrayerWeek {
  final String city;
  final List<PrayerDay> days;

  PrayerWeek({
    required this.city,
    required this.days,
  });

  factory PrayerWeek.fromJson(Map<String, dynamic> json) {
    return PrayerWeek(
      city: json['state'] ?? '',
      // explaination 
      days: List<PrayerDay>.from(
        json['items'].map((item) => PrayerDay.fromJson(item)),
      ),
    );
  }
}
