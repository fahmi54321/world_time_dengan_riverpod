// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TimeInfo extends Equatable {
  final String? abbreviation;
  final String? clientIp;
  final String? datetime;
  final int? dayOfWeek;
  final int? dayOfYear;
  final bool? dst;
  final String? dstFrom;
  final int? dstOffset;
  final String? dstUntil;
  final int? rawOffset;
  final String? timezone;
  final int? unixtime;
  final String? utcDatetime;
  final String? utcOffset;
  final int? weekNumber;
  TimeInfo({
    this.abbreviation,
    this.clientIp,
    this.datetime,
    this.dayOfWeek,
    this.dayOfYear,
    this.dst,
    this.dstFrom,
    this.dstOffset,
    this.dstUntil,
    this.rawOffset,
    this.timezone,
    this.unixtime,
    this.utcDatetime,
    this.utcOffset,
    this.weekNumber,
  });

  factory TimeInfo.fromJson(Map<String, dynamic> json) {
    return TimeInfo(
      abbreviation: json['abbreviation'],
      clientIp: json['client_ip'],
      datetime: json['datetime'],
      dayOfWeek: json['day_of_week'],
      dayOfYear: json['day_of_year'],
      dst: json['dst'],
      dstFrom: json['dst_from'],
      dstOffset: json['dst_offset'],
      dstUntil: json['dst_until'],
      rawOffset: json['raw_offset'],
      timezone: json['timezone'],
      unixtime: json['unixtime'],
      utcDatetime: json['utc_datetime'],
      utcOffset: json['utc_offset'],
      weekNumber: json['week_number'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['abbreviation'] = abbreviation;
    data['client_ip'] = clientIp;
    data['datetime'] = datetime;
    data['day_of_week'] = dayOfWeek;
    data['day_of_year'] = dayOfYear;
    data['dst'] = dst;
    data['dst_from'] = dstFrom;
    data['dst_offset'] = dstOffset;
    data['dst_until'] = dstUntil;
    data['raw_offset'] = rawOffset;
    data['timezone'] = timezone;
    data['unixtime'] = unixtime;
    data['utc_datetime'] = utcDatetime;
    data['utc_offset'] = utcOffset;
    data['week_number'] = weekNumber;
    return data;
  }

  @override
  List<Object> get props {
    return [
      abbreviation ?? '',
      clientIp ?? '',
      datetime ?? '',
      dayOfWeek ?? 0,
      dayOfYear ?? 0,
      dst ?? false,
      dstFrom ?? '',
      dstOffset ?? 0,
      dstUntil ?? '',
      rawOffset ?? 0,
      timezone ?? '',
      unixtime ?? 0,
      utcDatetime ?? '',
      utcOffset ?? '',
      weekNumber ?? 0,
    ];
  }
}
