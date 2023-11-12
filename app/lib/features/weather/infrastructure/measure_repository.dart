import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:nimbus/core/application/logger.dart';
import 'package:nimbus/core/domain/decoded_response.dart';
import 'package:nimbus/core/domain/request_failure.dart';
import 'package:nimbus/features/weather/domain/measure.dart';
import 'package:http/http.dart' as http;

class MeasureRepository {
  static const baseUrl = 'http://3.134.102.171:3000';

  Future<Either<RequestFailure, List<Measure>>> getTodayMeasures() async {
    const String url = '$baseUrl/measure/today';

    try {
      logger.i("-------- GET Request --------\n URL: $url");
      final data = await http.get(
        Uri.parse(url),
      );

      final response = DecodedResponse<List<dynamic>>(
        data.statusCode,
        jsonDecode(utf8.decode(data.bodyBytes)),
      );

      if (response.status == 404 || response.status == 400) {
        return Left(
          RequestFailure(
            status: response.status,
            message: 'error_fetching_measures',
          ),
        );
      }

      List<Measure> results =
          (response.body).map((e) => Measure.fromMap(e)).toList();

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
