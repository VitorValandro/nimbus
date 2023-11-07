import 'package:flutter/material.dart';
import 'package:nimbus/features/weather/domain/measure.dart';

class MeasureStore extends ChangeNotifier {
  static final MeasureStore instance = MeasureStore();

  static final List<Measure> _defaultMeasures = [];
  List<Measure> measure = [];

  List<Measure> _measure = _defaultMeasures;

  List<Measure> get current => _measure;

  Future<void> update(List<Measure> measure) async {
    _measure = measure;

    notifyListeners();
  }

  void reset() {
    _measure = _defaultMeasures;

    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
