import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:world_time_dengan_riverpod/data/model/time_info.dart';

class WorldTimeApi {
  static const String baseUrl = "http://worldtimeapi.org/api";

  static Future<TimeInfo?> getCurrentTime({
    String timeZone = '',
  }) async {
    http.Response res = await http.get(Uri.parse("$baseUrl/ip"));
    if (res != null && res.statusCode == 200) {
      return TimeInfo.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }

  static Future<TimeInfo> getTimezoneTime(String timeZone) async {
    http.Response res = await http.get(
      Uri.parse(
        "$baseUrl/timezone/$timeZone",
      ),
    );

    return TimeInfo.fromJson(
      jsonDecode(
        res.body,
      ),
    );
  }

  static Future<List<String>> getTimeZones() async {
    http.Response res = await http.get(Uri.parse("$baseUrl/timezone"));
    if (res != null) {
      return List<String>.from(jsonDecode(res.body));
    } else {
      return [];
    }
  }
}
