import 'package:dartz/dartz.dart';
import 'package:nimbus/core/application/logger.dart';
import 'package:nimbus/core/domain/request_failure.dart';
import 'package:nimbus/features/weather/domain/measure.dart';
import 'package:http/http.dart' as http;

class MeasureRepository {
  static const baseUrl = 'http://3.134.102.171:3000';

  Future<Either<RequestFailure, List<Measure>>> getTodayMeasures() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/measure/today'),
      );

      if (response.statusCode == 404 || response.statusCode == 400) {
        return Left(
          RequestFailure(
            status: response.statusCode,
            message: 'error_fetching_measures',
          ),
        );
      }

      List<Measure> results = (response.body as List<dynamic>)
          .map((e) => Measure.fromMap(e))
          .toList();

      return Right(results);
    } catch (exception, stackTrace) {
      logger.f(
        'Error fetching measures',
        error: exception,
        stackTrace: stackTrace,
      );
      return Left(RequestFailure(message: 'incorrect_cada_id'));
    }
  }
}
