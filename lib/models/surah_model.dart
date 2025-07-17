import 'package:quran/widgets/surahListItem.dart';

class Surah_item {
  int? number , startPage;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  Surah_item({
    this.startPage,
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  // Surah_item.fromJson(Map<String, dynamic> json) {
  //   number = json['number'];
  //   name = json['name'];
  //   englishName = json['englishName'];
  //   englishNameTranslation = json['englishNameTranslation'];
  //   numberOfAyahs = json['numberOfAyahs'];
  //   revelationType = json['revelationType'];
  // }

  factory Surah_item.fromMap(Map<String, dynamic> map) {
    return Surah_item(
      number: map['number'],
      name: map['name'],
      englishName: map['englishName'],
      englishNameTranslation: map['englishNameTranslation'],
      numberOfAyahs: map['numberOfAyahs'],
      revelationType: map['revelationType'],
      startPage: map['startPage'],
    );
  }
}
