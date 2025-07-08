part of 'prayer_cubit.dart';

@immutable
sealed class PrayerState {}

final class PrayerInitial extends PrayerState {}
class PrayerLoaded extends PrayerState {
  final PrayerWeek prayerWeek;

  PrayerLoaded(this.prayerWeek);
}

class PrayerError extends PrayerState {
  final String message;

  PrayerError(this.message);
}
