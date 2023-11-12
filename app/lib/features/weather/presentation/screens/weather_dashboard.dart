import 'package:flutter/material.dart';
import 'package:nimbus/core/application/logger.dart';
import 'package:nimbus/features/weather/application/measure_service.dart';
import 'package:nimbus/features/weather/domain/measure.dart';

class WeatherDashboard extends StatefulWidget {
  const WeatherDashboard({super.key, required this.title});

  final String title;

  @override
  State<WeatherDashboard> createState() => _WeatherDashboardState();
}

class _WeatherDashboardState extends State<WeatherDashboard> {
  int _counter = 0;
  Measure? latestMeasure;
  final MeasuresService _measuresService = MeasuresService();

  @override
  void initState() {
    super.initState();
    _measuresService.fetchMeasures();
    latestMeasure = _measuresService.getLatestMeasure();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.d(latestMeasure);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
