import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:world_time_dengan_riverpod/data/model/time_info.dart';

class ClocksNotifier extends StateNotifier<List<TimeInfo>> {
  ClocksNotifier() : super([]);

  add(TimeInfo clock) {
    var temp = state;
    temp.add(clock);
    state = temp;
  }

  remove(TimeInfo clock) {
    var temp = state;
    temp.remove(clock);
    state = temp;
  }
}

final clocksProvider = StateNotifierProvider<ClocksNotifier, List<TimeInfo>>(
    (ref) => ClocksNotifier());
