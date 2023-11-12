import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nimbus/core/application/logger.dart';
import 'package:nimbus/core/utils/spacing.dart';
import 'package:nimbus/features/weather/application/measure_service.dart';
import 'package:nimbus/features/weather/domain/measure.dart';
import 'package:nimbus/features/weather/domain/zambretti.dart';

class WeatherDashboard extends StatefulWidget {
  const WeatherDashboard({super.key, required this.title});

  final String title;

  @override
  State<WeatherDashboard> createState() => _WeatherDashboardState();
}

class _WeatherDashboardState extends State<WeatherDashboard> {
  Measure? latestMeasure;
  final MeasuresService _measuresService = MeasuresService();

  @override
  void initState() {
    super.initState();

    () async {
      await _measuresService.fetchMeasures();
      setState(() {
        latestMeasure = _measuresService.getLatestMeasure();
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    logger.d(latestMeasure);

    if (latestMeasure == null) return const Scaffold();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: RadialGradient(radius: 0.7, colors: [
                latestMeasure!.zambretti.gradientColor,
                Colors.white,
              ]),
            ),
            child: Lottie.asset(latestMeasure!.zambretti.animation),
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
                  child: const Text(
                    "Florianópolis",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ),
                const Spacer(),
                // Container(
                //   alignment: Alignment.center,
                //   child: Lottie.asset(latestMeasure!.zambretti.animation),
                // ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: Spacing.value(2)),
                        child: Text(
                          latestMeasure!.zambretti.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 42,
                          ),
                        ),
                      ),
                      Text(
                        latestMeasure!.formattedTemperature,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 36,
                        ),
                      ),
                      Text(latestMeasure!.formattedMoisture,
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
                    latestMeasure!.formattedTime,
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
