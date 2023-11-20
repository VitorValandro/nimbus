import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:nimbus/features/weather/application/measure_service.dart';
import 'package:nimbus/features/weather/domain/measure.dart';
import 'package:nimbus/features/weather/presentation/screens/weather_charts.dart';
import 'package:nimbus/features/weather/presentation/screens/weather_dashboard.dart';

void main() {
  initializeDateFormatting('pt_BR');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = false;
  Measure? latestMeasure;

  final MeasuresService _measuresService = MeasuresService();

  @override
  void initState() {
    super.initState();
    fetchMeasures();
  }

  void fetchMeasures() async {
    setState(() => loading = true);
    await _measuresService.fetchMeasures();
    setState(() {
      latestMeasure = _measuresService.getLatestMeasure();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
        home: loading
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  alignment: Alignment.center,
                  child: Lottie.asset('assets/spinner.json'),
                ),
              )
            : PageView(
                children: [
                  WeatherDashboard(
                    latestMeasure: latestMeasure!,
                    onRefresh: fetchMeasures,
                  ),
                  const WeatherCharts()
                ],
              ));
  }
}
