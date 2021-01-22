import '../value_validated.dart';

final easaRE = RegExp(r'(\d{2})/(\d{2})/(\d{4})');

class Date extends ValueValidated<String> {
  final String _dateValue;
  final Validator _validator;

  Date._(this._dateValue, this._validator) : super(_dateValue, _validator);

  factory Date.fromEASAString(String txt) {
    return Date._(txt, EASADateValidator(txt));
  }

  String get asEASAString {
    if (isValid) {
      if (_validator is EASADateValidator) return _dateValue;
    } else {
      throw ValueValidatedError(
          'asEASAString getter called on an invalid Date!');
    }
  }

  DateTime get asDateTime {
    if (isValid) {
      if (_validator is EASADateValidator) {
        final match = easaRE.firstMatch(value);
        return DateTime(
            int.parse(match.group(3)), // year
            int.parse(match.group(2)), // month
            int.parse(match.group(1))); // day
      } else {
        throw UnimplementedError(
            'Date validator case not implemented in asDateTime getter');
      }
    } else {
      throw ValueValidatedError('asDateTime getter called on an invalid Date!');
    }
  }
}

class EASADateValidator extends Validator<String> {
  EASADateValidator(String value) : super(value);

  @override
  Failure getFailureOrNull() {
    if (value.length != 10) return EASAStringDateFailure();
    if (easaRE.hasMatch(value)) {
      return null;
    } else {
      return EASAStringDateFailure();
    }
  }
}

class EASAStringDateFailure extends Failure {}
