import 'package:dartz/dartz.dart';
import 'package:nimbus/core/domain/chart_data.dart';
import 'package:nimbus/core/domain/request_failure.dart';
import 'package:nimbus/features/weather/domain/measure.dart';
import 'package:nimbus/features/weather/infrastructure/measure_repository.dart';
import 'package:nimbus/features/weather/infrastructure/measure_store.dart';

class MeasuresService {
  final MeasureRepository _repository = MeasureRepository();
  final MeasureStore _measuresStore = MeasureStore.instance;

  Future<void> fetchMeasures({
    void Function(List<Measure>)? onSuccess,
    void Function(RequestFailure)? onFailure,
  }) async {
    Either<RequestFailure, List<Measure>> measuresResponse =
        await _repository.getTodayMeasures();

    measuresResponse.fold(
      (failure) async {
        await _measuresStore.update([]);

        if (onFailure != null) onFailure(failure);
      },
      (measures) async {
        await _measuresStore.update(measures);
        if (onSuccess != null) onSuccess(measures);
      },
    );
  }

  Measure? getLatestMeasure() {
    return _measuresStore.current.firstOrNull;
  }

  List<ChartData>? getTodayMeasureTemperatureChartData() {
    List<Measure> measures = _measuresStore.current;
    return Measure.getTemperatureCharData(measures);
  }

  List<ChartData>? getTodayMeasureMoistureChartData() {
    List<Measure> measures = _measuresStore.current;
    return Measure.getMoistureCharData(measures);
  }
}
