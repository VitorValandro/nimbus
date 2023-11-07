abstract class ValueFailure<T> {
  final T value;
  final String errorKey;
  final Map<String, String>? args;

  ValueFailure({required this.value, required this.errorKey, this.args});
}

class EmptyStringFailure extends ValueFailure<String> {
  EmptyStringFailure(String failedValue)
      : super(value: failedValue, errorKey: 'empty_string_failure');
}

class TooLongStringFailure extends ValueFailure<String> {
  TooLongStringFailure(String failedValue, int maxLength)
      : super(
          value: failedValue,
          errorKey: 'too_long_string_failure',
          args: {'maxLength': maxLength.toString()},
        );
}

class TooShortStringFailure extends ValueFailure<String> {
  TooShortStringFailure(String failedValue, int minLength)
      : super(
          value: failedValue,
          errorKey: 'too_short_string_failure',
          args: {'minLength': minLength.toString()},
        );
}

class NotAnEmailStringFailure extends ValueFailure<String> {
  NotAnEmailStringFailure(String failedValue)
      : super(value: failedValue, errorKey: 'not_an_email_string_failure');
}

class InvalidImagePathFailure extends ValueFailure<String> {
  InvalidImagePathFailure(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_image_path_failure');
}

class InvalidHexColorFailure extends ValueFailure<String> {
  InvalidHexColorFailure(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_hex_color_failure');
}

class NotMatchingPasswords extends ValueFailure<String> {
  NotMatchingPasswords(String failedValue)
      : super(value: failedValue, errorKey: 'not_matching_passwords');
}

class InvalidUuidFailure extends ValueFailure<String> {
  InvalidUuidFailure(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_uuid');
}

class InvalidCountryCodeFailure extends ValueFailure<String> {
  InvalidCountryCodeFailure(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_country_code');
}

class InvalidECodeFailure extends ValueFailure<String> {
  InvalidECodeFailure(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_e_code');
}

class InvalidDateStringFailure extends ValueFailure<String> {
  InvalidDateStringFailure(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_date_string');
}

class InvalidPhoneNumber extends ValueFailure<String> {
  InvalidPhoneNumber(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_phone_number');
}

class InvalidGender extends ValueFailure<String> {
  InvalidGender(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_gender');
}

class InvalidPinCode extends ValueFailure<String> {
  InvalidPinCode(String failedValue)
      : super(value: failedValue, errorKey: 'invalid_pin_code');
}

class RegexFailure extends ValueFailure<String> {
  RegexFailure(String failedValue)
      : super(value: failedValue, errorKey: 'regex_failure');
}
