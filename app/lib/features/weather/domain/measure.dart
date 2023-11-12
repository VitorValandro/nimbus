import 'dart:convert';

import 'package:nimbus/core/domain/date_value.dart';
import 'package:nimbus/features/weather/domain/zambretti.dart';

class Measure {
  DateValue timestamp;
  double pressure;
  double moisture;
  double temperature;
  ZambrettiEnum zambretti;
  Measure({
    required this.timestamp,
    required this.pressure,
    required this.moisture,
    required this.temperature,
    required this.zambretti,
  });

  Measure copyWith({
    DateValue? timestamp,
    double? pressure,
    double? moisture,
    double? temperature,
    ZambrettiEnum? zambretti,
  }) {
    return Measure(
      timestamp: timestamp ?? this.timestamp,
      pressure: pressure ?? this.pressure,
      moisture: moisture ?? this.moisture,
      temperature: temperature ?? this.temperature,
      zambretti: zambretti ?? this.zambretti,
    );
  }

  factory Measure.fromMap(Map<String, dynamic> map) {
    return Measure(
      timestamp: DateValue.create(map['timestamp']),
      pressure: map['pressure'].toDouble(),
      moisture: map['moisture'].toDouble(),
      temperature: getTemperaturesMean(
        map['temperature_dht22'].toDouble(),
        map['temperature_bmp180'].toDouble(),
      ),
      zambretti:
          ZambrettiExtension.getZambrettiEnumFromInt(map['zambretti'].toInt()),
    );
  }

  factory Measure.fromJson(String source) =>
      Measure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Measure(timestamp: $timestamp, pressure: $pressure, moisture: $moisture, temperature: $temperature, zambretti: $zambretti)';
  }

  @override
  bool operator ==(covariant Measure other) {
    if (identical(this, other)) return true;

    return other.timestamp == timestamp &&
        other.pressure == pressure &&
        other.moisture == moisture &&
        other.temperature == temperature &&
        other.zambretti == zambretti;
  }

  @override
  int get hashCode {
    return timestamp.hashCode ^
        pressure.hashCode ^
        moisture.hashCode ^
        temperature.hashCode ^
        zambretti.hashCode;
  }

  static double getTemperaturesMean(
    double temperatureDht22,
    double temperatureBmp180,
  ) {
    return (temperatureDht22 + temperatureBmp180) / 2;
  }
}
