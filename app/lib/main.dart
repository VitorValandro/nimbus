import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nimbus/features/weather/presentation/screens/weather_dashboard.dart';

void main() {
  initializeDateFormatting('pt_BR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const WeatherDashboard(title: 'Flutter Demo Home Page'),
    );
  }
}
