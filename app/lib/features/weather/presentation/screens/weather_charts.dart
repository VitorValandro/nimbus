import 'package:flutter/material.dart';
import 'package:nimbus/core/utils/spacing.dart';
import 'package:nimbus/features/weather/presentation/charts/moisture_chart.dart';
import 'package:nimbus/features/weather/presentation/charts/temperature_chart.dart';

class WeatherCharts extends StatelessWidget {
  const WeatherCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          top: Spacing.value(4),
          bottom: Spacing.value(8),
          left: Spacing.value(2),
          right: Spacing.value(2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: Spacing.value(4)),
              child: const Text(
                "Histórico diário",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: Spacing.value(4)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temperatura',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  TemperatureChart()
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Humidade',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                MoistureChart()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
