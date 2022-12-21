import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:world_time_dengan_riverpod/data/model/time_info.dart';
import 'package:world_time_dengan_riverpod/data/service/worldtime_api.dart';

class TimezoneNotifier extends StateNotifier<List<String>> {
  TimezoneNotifier() : super([]) {
    getTimeZone();
  }

  getTimeZone() async {
    final time = await WorldTimeApi.getTimeZones();
    if (time.isNotEmpty) {
      state = time;
    }
  }
}

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

final timezone = FutureProvider<TimeInfo?>((ref) async {
  return WorldTimeApi.getCurrentTime();
});

final timeZonesProvider = StateNotifierProvider<TimezoneNotifier, List<String>>(
  (ref) => TimezoneNotifier(),
);
