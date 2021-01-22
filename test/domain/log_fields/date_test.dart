import 'package:flog/domain/log_fields/date.dart';
import 'package:flog/domain/value_validated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date validators tests', () {
    group('EASA Date validator tests', () {
      test('EASA Date validator shall validate "15/11/1978"', () {
        final validator = EASADateValidator('15/11/1978');
        expect(validator.getFailureOrNull(), null);
      });
      test('EASA Date validator shall not validate "15-11-1978"', () {
        final validator = EASADateValidator('15-11-1978');
        expect(validator.getFailureOrNull(), isA<EASAStringDateFailure>());
      });
    });
    group('asEASAString getter', () {
      test('shall return "15/11/1978"', () {
        final date = Date.fromEASAString('15/11/1978');
        expect(date.asEASAString, '15/11/1978');
      });
      test('asEASAString getter should throw a ValueValidatedError if called on an invalid Date', () {
        final date = Date.fromEASAString('15-11-1978');
        expect(() => date.asEASAString, throwsA(isA<ValueValidatedError>()));
      });
    });
    group('asDateTime getter', () {
      test('shall work with "15/11/1978"', () {
        final date = Date.fromEASAString('15/11/1978');
        expect(date.asDateTime, DateTime(1978, 11, 15));
      });
      test('asDateTime getter should throw a ValueValidatedError if called on an invalid Date', () {
        final date = Date.fromEASAString('15-11-1978');
        expect(() => date.asDateTime, throwsA(isA<ValueValidatedError>()));
      });
    });
  });
}