import 'package:dartz/dartz.dart';
import './failures.dart';

Either<ValueFailure<String>, String> validateDateString({
  String? value,
}) {
  try {
    DateTime.parse(value as String);
    return Right(value);
  } on Exception {
    return Left(InvalidDateStringFailure(value ?? ''));
  }
}
