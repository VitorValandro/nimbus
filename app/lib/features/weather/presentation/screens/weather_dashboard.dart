import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nimbus/core/utils/spacing.dart';
import 'package:nimbus/features/weather/domain/measure.dart';
import 'package:nimbus/features/weather/domain/zambretti.dart';

class WeatherDashboard extends StatelessWidget {
  const WeatherDashboard(
      {key, required this.latestMeasure, required this.onRefresh})
      : super(key: key);

  final Measure latestMeasure;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: RadialGradient(radius: 0.7, colors: [
                latestMeasure.zambretti.gradientColor,
                Colors.white,
              ]),
            ),
            child: Lottie.asset(latestMeasure.zambretti.animation),
          ),
          Container(
            padding: EdgeInsets.only(
                top: Spacing.value(8),
                bottom: Spacing.value(4),
                left: Spacing.value(6),
                right: Spacing.value(6)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Florianópolis",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                      ),
                      IconButton(
                          onPressed: onRefresh, icon: const Icon(Icons.refresh))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: Spacing.value(2)),
                  child: Text(
                    latestMeasure.zambretti.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: Spacing.value(2)),
                        child: Text(
                          latestMeasure.zambretti.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 42,
                          ),
                        ),
                      ),
                      Text(
                        latestMeasure.formattedTemperature,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 36,
                        ),
                      ),
                      Text(latestMeasure.formattedMoisture,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 28,
                          )),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    latestMeasure.formattedTime,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
