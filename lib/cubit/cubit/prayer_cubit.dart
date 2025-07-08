import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerInitial());
}
