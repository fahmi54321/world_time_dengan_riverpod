import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:world_time_dengan_riverpod/data/model/time_info.dart';
import 'package:world_time_dengan_riverpod/data/service/worldtime_api.dart';
import 'package:world_time_dengan_riverpod/presentation/notifier/clocks_notifier.dart';
import 'package:world_time_dengan_riverpod/presentation/notifier/timezone_notifier.dart';

class TimezonesPage extends ConsumerStatefulWidget {
  @override
  _TimezonesPageState createState() => _TimezonesPageState();
}

class _TimezonesPageState extends ConsumerState<TimezonesPage> {
  String _timezone = '';
  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timeZones = ref.watch(timeZonesProvider);
    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        title: const Text('Select timezone'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownSearch<String>(
              onChanged: (tz) {
                setState(() {
                  _timezone = tz ?? '';
                });
              },
              items: timeZones,
              selectedItem: _timezone,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_timezone.isEmpty) return;
                setState(() {
                  _loading = true;
                });
                bool exists = false;
                ref.read(clocksProvider).forEach((element) {
                  if (element.timezone == _timezone) {
                    exists = true;
                  }
                });
                if (!exists) {
                  TimeInfo info = await WorldTimeApi.getTimezoneTime(_timezone);

                  ref.read(clocksProvider).add(info);
                  setState(() {
                    _loading = false;
                  });

                  if (mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  setState(() {
                    _loading = false;
                  });
                }
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
