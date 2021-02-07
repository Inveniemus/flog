import '../value_validated.dart';

class AircraftRegistration extends ValueValidated<String> {
  AircraftRegistration._(String value, Validator<String> validator) : super(value, validator);

  factory AircraftRegistration.fromType(String value) {
    return AircraftRegistration._(value, AircraftRegistrationValidator(value));
  }
}

class AircraftRegistrationValidator extends Validator<String> {
  AircraftRegistrationValidator(String value) : super(value);

  @override
  Failure getFailureOrNull() {
    // Never fails
    return null;
  }
}