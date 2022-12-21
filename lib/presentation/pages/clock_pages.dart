import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_time_dengan_riverpod/data/model/time_info.dart';
import 'package:world_time_dengan_riverpod/presentation/notifier/clocks_notifier.dart';
import 'package:world_time_dengan_riverpod/presentation/notifier/timezone_notifier.dart';
import 'package:world_time_dengan_riverpod/presentation/widgets/clocks_container.dart';
import 'package:world_time_dengan_riverpod/presentation/widgets/clocks_hand.dart';
import 'package:world_time_dengan_riverpod/res/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClockPage extends ConsumerStatefulWidget {
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends ConsumerState<ClockPage> {
  Timer? timer;
  List<TimeInfo> clocks = [];

  @override
  void initState() {
    super.initState();

    init();
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        timer = Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            ref.read(timeProvider.notifier).state =
                ref.read(timeProvider.notifier).state.add(
                      const Duration(seconds: 1),
                    );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final time = ref.watch(timeProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Row(
              children: [
                const Spacer(),
                MaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.pink,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.timezonesPage);
                  },
                ),
              ],
            ),
            Column(
              children: [
                ClockContainer(
                  child: CustomPaint(
                    painter: ClockHands(
                      time: time,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Consumer(builder: (context, refs, _) {
                  final timeinfo = refs.watch(timezone);
                  return timeinfo.when(
                    data: (timeInfos) => Text(
                      timeInfos?.timezone ?? '',
                      style: const TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0,
                      ),
                    ),
                    error: (err, stack) => Container(),
                    loading: () => const CircularProgressIndicator(),
                  );
                }),
                Text(
                  DateFormat.jm().format(
                    DateTime.now(),
                  ),
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 10.0),
              ],
            ),
            SizedBox(
              height: 180,
              child: Consumer(builder: (context, refs, _) {
                List<TimeInfo> clocks = refs.watch(clocksProvider);
                DateTime time2 = refs.watch(timeProvider);
                return (clocks.isNotEmpty)
                    ? ListView.builder(
                        itemCount: clocks.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          TimeInfo clock = clocks[index];
                          DateTime time = time2.toUtc();
                          int rawOffset = clock.rawOffset?.toInt() ?? 0;
                          int dstOffset = clock.dstOffset?.toInt() ?? 0;
                          int offset = rawOffset + dstOffset;
                          if (rawOffset > 0) {
                            time = time.add(Duration(seconds: offset));
                          } else if (rawOffset < 0) {
                            time = time.subtract(
                              Duration(
                                seconds: (offset * -1),
                              ),
                            );
                          }
                          return Card(
                            child: Stack(
                              children: [
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        clock.timezone ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        clock.utcOffset ?? '',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 15.0),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              DateFormat.yMMMd().format(time),
                                            ),
                                          ),
                                          Text(
                                            DateFormat.jm().format(time),
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontSize: 24.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      refs
                                          .read(clocksProvider.notifier)
                                          .remove(clock);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                    : Container();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
