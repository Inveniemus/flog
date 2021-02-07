import 'package:flog/domain/log_fields/flight_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flight time validator tests', () {
    test('shall validate 01:00', () {
      final time = '01:00';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  true);
    });
    test('shall validate 00:00', () {
      final time = '00:00';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  true);
    });
    test('shall validate 0:00', () {
      final time = '0:00';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  true);
    });
    test('shall validate 1:1', () {
      final time = '1:1';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  true);
    });
    test('shall validate 99:59', () {
      final time = '99:59';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  true);
    });
    test('shall validate 99999:59', () {
      final time = '99999:59';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  true);
    });
    test('shall not validate 99999:99', () {
      final time = '99999:99';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  false);
    });
    test('shall not validate 00:60', () {
      final time = '99999:99';
      expect(FlightTimeValidator(time).getFailureOrNull() == null,  false);
    });
  });
  
  group('FlightTime constructor', () {
    test('shall validate 01:00', () {
      final time = '01:00';
      expect(FlightTime.from(time).isValid,  true);
    });
    test('shall validate 00:00', () {
      final time = '00:00';
      expect(FlightTime.from(time).isValid,  true);
    });
    test('shall validate 0:00', () {
      final time = '0:00';
      expect(FlightTime.from(time).isValid,  true);
    });
    test('shall validate 1:1', () {
      final time = '1:1';
      expect(FlightTime.from(time).isValid,  true);
    });
    test('shall validate 99:59', () {
      final time = '99:59';
      expect(FlightTime.from(time).isValid,  true);
    });
    test('shall validate 99999:59', () {
      final time = '99999:59';
      expect(FlightTime.from(time).isValid,  true);
    });
    test('shall not validate 99999:99', () {
      final time = '99999:99';
      expect(FlightTime.from(time).isValid,  false);
    });
    test('shall not validate 00:60', () {
      final time = '99999:99';
      expect(FlightTime.from(time).isValid,  false);
    });
  });
}