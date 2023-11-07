import 'package:dartz/dartz.dart';
import 'package:cada/features/session/domain/gender.dart';
import './failures.dart';

Either<ValueFailure<String>, String> validateNonEmptyString({
  required String value,
}) {
  if (value.isNotEmpty) {
    return Right(value);
  } else {
    return Left(EmptyStringFailure(value));
  }
}

Either<ValueFailure<String>, String> validateMaxLength({
  required String value,
  required int maxLength,
}) {
  if (value.length <= maxLength) {
    return Right(value);
  } else {
    return Left(TooLongStringFailure(value, maxLength));
  }
}

Either<ValueFailure<String>, String> validateMinLength({
  required String value,
  required int minLength,
}) {
  if (value.length >= minLength) {
    return Right(value);
  } else {
    return Left(TooShortStringFailure(value, minLength));
  }
}

Either<ValueFailure<String>, String> validateEmailString({
  required String value,
}) {
  RegExp emailRegex = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');

  if (emailRegex.hasMatch(value)) {
    return Right(value.toLowerCase());
  } else {
    return Left(
      NotAnEmailStringFailure(
        value,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateImagePath({
  required String value,
}) {
  RegExp imagePathRegex = RegExp(r'^(\/+[a-zA-Z0-9_]+)+\.jpg$');

  if (imagePathRegex.hasMatch(value)) {
    return Right(value);
  } else {
    return Left(InvalidImagePathFailure(value));
  }
}

Either<ValueFailure<String>, String> validateHexColor({
  required String value,
}) {
  RegExp hexColorRegex = RegExp(r'^([0-9a-fA-F]{6}|[0-9a-fA-F]{3})$');

  if (hexColorRegex.hasMatch(value)) {
    return Right(value);
  } else {
    return Left(InvalidHexColorFailure(value));
  }
}

//For password confirmation
Either<ValueFailure<String>, String> validateSimilarValue({
  required String value,
  required String comparedTo,
}) {
  if (value == comparedTo) {
    return Right(value);
  } else {
    return Left(NotMatchingPasswords(value));
  }
}

Either<ValueFailure<String>, String> validateUuid({
  required String value,
}) {
  RegExp uuidRegex = RegExp(
    r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$',
  );

  if (uuidRegex.hasMatch(value)) {
    return Right(value);
  } else {
    return Left(InvalidUuidFailure(value));
  }
}

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

Either<ValueFailure<String>, String> validatePhoneNumber({
  required String value,
}) {
  RegExp germanPhoneNumberRegex =
      RegExp(r'^\(?\+\(?49\)?[ ()]?([- ()]?\d[- ()]?){10}$');
  RegExp swissPhoneNumberRegex = RegExp(
    r'^(\+41|0041|\(?\+41\)?)(\s?\d{2}\s?\d{3}\s?\d{2}\s?\d{2})$',
  );

  if (swissPhoneNumberRegex.hasMatch(value) ||
      germanPhoneNumberRegex.hasMatch(value)) {
    return Right(value);
  } else {
    return Left(
      InvalidPhoneNumber(
        value,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateGender({
  required String value,
}) {
  if (value == genderEnum[GenderEnum.male] ||
      value == genderEnum[GenderEnum.female]) {
    return Right(value);
  } else {
    return Left(
      InvalidGender(
        value,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validatePinCode({
  required String value,
}) {
  RegExp exactSixDigitsRegex = RegExp(r'^[0-9]{6}$');

  if (exactSixDigitsRegex.hasMatch(value)) {
    return Right(value);
  } else {
    return Left(
      InvalidPinCode(
        value,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateRegex({
  required String value,
  required RegExp regex,
}) {
  if (regex.hasMatch(value)) {
    return Right(value);
  } else {
    return Left(RegexFailure(value));
  }
}

Either<ValueFailure<String>, String> validatePasswordRegex({
  required String value,
  required List<RegExp> passwordRegex,
}) {
  for (RegExp regex in passwordRegex) {
    if (!regex.hasMatch(value)) {
      return Left(RegexFailure(value));
    }
  }

  return Right(value);
}
