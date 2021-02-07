import 'package:flog/domain/value_validated.dart';

final flightTimeRE = RegExp(r'(\d+)\:(\d{1,2})');

class FlightTime extends ValueValidated<String> {
  FlightTime._(String value, Validator<String> validator)
      : super(value, validator);

  factory FlightTime.from(String value) {
    return FlightTime._(value, FlightTimeValidator(value));
  }
}

class FlightTimeValidator extends Validator<String> {
  FlightTimeValidator(String value) : super(value);

  @override
  Failure getFailureOrNull() {
    final match = flightTimeRE.firstMatch(value);

    if (match == null) {
      return FlightTimeFormatFailure(
          'Flight Time format not recognized: $value');

    } else {
      final hours = int.tryParse(match.group(1));
      final minutes = int.tryParse(match.group(2));
      if (hours == null || minutes == null) {
        return FlightTimeFormatFailure(
            'Flight Time parsing error on string: $value');
      }
      if (minutes < 0 || minutes > 59) {
        return FlightTimeFormatFailure('Flight Time minutes are incorrect in $value.');
      }
    }
    return null;
  }
}

class FlightTimeFormatFailure extends Failure {
  FlightTimeFormatFailure(String description) : super(description: description);
}
