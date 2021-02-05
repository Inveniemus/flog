import '../value_validated.dart';

class Airport extends ValueValidated<String> {
  Airport._(String value, Validator validator) : super(value, validator);

  factory Airport.fromIATA(String value) {
    return Airport._(value, IATAValidator(value));
  }

  factory Airport.fromICAO(String value) {
    return Airport._(value, ICAOValidator(value));
  }
}

class IATAValidator extends Validator<String> {
  IATAValidator(String value) : super(value);

  @override
  Failure getFailureOrNull() {
    if (value.length != 3)
      return IATACodeFailure('IATA code is not 3-letters long');
  }
}

class ICAOValidator extends Validator<String> {
  ICAOValidator(String value) : super(value);

  @override
  Failure getFailureOrNull() {
    if (value.length != 4)
      return ICAOCodeFailure('ICAO code is not 3-letters long');
  }
}

class IATACodeFailure extends Failure {
  IATACodeFailure(String description) : super(description: description);
}

class ICAOCodeFailure extends Failure {
  ICAOCodeFailure(String description) : super(description: description);
}

String _correctAndValidateAirportCode(String value) {
  if (value.length != 3 && value.length != 4 || value == null)
    throw StateError(
        'Airport code correction attempted on a non-3 and non-4 letter value.');
  final iataRE = RegExp(r'[a-z|A-Z]{3}');
  final icaoRE = RegExp(r'[a-z|A-Z]{4}');

  if (iataRE.hasMatch(value) || icaoRE.hasMatch(value)) {
    return value.toUpperCase();
  } else {
    return null;
  }
}
