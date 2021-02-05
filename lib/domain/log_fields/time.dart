import '../value_validated.dart';

final timeRE = RegExp(r'(\d{2})\:(\d{2})');

class Time extends ValueValidated<String> {
  Time._(value, Validator validator) : super(value, validator);

  factory Time.format24(String value) {
    return Time._(value, TimeValidator(value));
  }

    
}

class TimeValidator extends Validator<String> {
  TimeValidator(String value) : super(value);

  @override
  Failure getFailureOrNull() {
    if (value.length != 5)
      return InvalidTimeFormat(
          'Time string length is not 5. Failing value: $value');

    final match = timeRE.firstMatch(value);
    final hour = int.parse(match.group(1));
    final minute = int.parse(match.group(2));

    if (hour > 23) return InvalidTimeFormat('Hour is more than 23');
    if (minute > 59) return InvalidTimeFormat('Hour is more than 59');

    return null;
  }
}

class InvalidTimeFormat extends Failure {
  InvalidTimeFormat(String description) : super(description: description);
}
