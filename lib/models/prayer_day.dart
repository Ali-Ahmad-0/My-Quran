class PrayerDay {
  final String date;
  final String fajr;
  final String shurooq;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerDay({
    required this.date,
    required this.fajr,
    required this.shurooq,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerDay.fromJson(Map<String, dynamic> json) {
    return PrayerDay(
      date: json['date_for'],
      fajr: json['fajr'],
      shurooq: json['shurooq'],
      dhuhr: json['dhuhr'],
      asr: json['asr'],
      maghrib: json['maghrib'],
      isha: json['isha'],
    );
  }
}
