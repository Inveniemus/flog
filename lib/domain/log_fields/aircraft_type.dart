import '../value_validated.dart';

class AircraftType extends ValueValidated<String> {
  AircraftType._(String value, Validator<String> validator) : super(value, validator);

  factory AircraftType.fromType(String value) {
    return AircraftType._(value, AircraftTypeValidator(value));
  }
}

class AircraftTypeValidator extends Validator<String> {
  AircraftTypeValidator(String value) : super(value);

  @override
  Failure getFailureOrNull() {
    // Never fails
    return null;
  }
}