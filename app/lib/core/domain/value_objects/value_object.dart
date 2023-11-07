import 'package:dartz/dartz.dart';
import 'failures.dart';

class InvalidValueError extends Error {}

abstract class ValueObject<T> {
  final Either<ValueFailure<T>, T> _val;

  ValueObject(this._val);

  bool isValid() {
    return _val.isRight();
  }

  T getOrCrash() {
    if (!isValid()) {
      throw InvalidValueError();
    }
    return getValue();
  }

  ValueFailure? getFailure() {
    return _val.fold<ValueFailure?>((ValueFailure<T> l) => l, (T r) => null);
  }

  T getValue() {
    return _val.fold<T>((ValueFailure<T> l) => l.value, (T r) => r);
  }
}
