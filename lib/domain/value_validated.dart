/// This class represents a value-validated object.
///
/// Each value-validated object has to:
/// * Provide one (or more) meaningful failure implementation,
/// * Provide the Validator implementation,
/// * extend this class.
abstract class ValueValidated<T> {
  final T _value;
  final Validator<T> _validator;

  Failure _failure;
  T _validatedValue;

  ValueValidated(this._value, this._validator);

  bool get isValid {
    if (_failure == null) {
      _processValidator();
      return isValid;
    } else if (_failure is NoFailure) {
      return true;
    } else { // Failure case
      return false;
    }
  }

  bool get isFailed => !isValid;

  /// Failure getter, to be used only if value is failed, otherwise a
  /// [ValueValidatedError] is thrown. Use isFailed before this getter.
  Failure get failure {
    if (isFailed) return _failure;
    throw ValueValidatedError('failure getter called on a non failed value');
  }

  /// Value getter, to be used only if value is valid, otherwise a
  /// [ValueValidatedError] is thrown. Use isValid before this getter.
  T get value {
    if (isValid) return _validatedValue;
    throw ValueValidatedError('value getter called on a failed value.');
  }

  void _processValidator() {
    final validatorResult = _validator.getFailureOrNull();
    if (validatorResult == null) {
      _failure = NoFailure();
      _validatedValue = _value;
    } else {
      _failure = validatorResult;
      _validatedValue = null;
    }
  }
}

/// When extended, this class contains validation logic in the concrete
/// [getFailureOrNull] method.
///
/// It is intended to be used by a [ValueValidated] object. To use it, extend it
/// by providing the getFailureOrNull method.
abstract class Validator<T> {
  final T _value;
  const Validator(this._value);

  T get value => _value;

  /// Method for validation logic. If it returns null, value is
  /// validated. Otherwise, it shall return a concrete implementation of
  /// Failure.
  Failure getFailureOrNull();
}

/// This class represents a failed value of a value validated object (a
/// [ValueValidated] class). To use it, implement it with a meaningful
/// class name.
abstract class Failure {
  final String description;
  const Failure({this.description = 'No description.'});
}

class NoFailure extends Failure {}

/// This error is thrown when a ValueValidated object is not used as it is
/// intended to, i.e. using getters when value is not valid.
class ValueValidatedError extends StateError {
  final String message;
  ValueValidatedError(this.message) : super(message);
}