import 'package:flutter_test/flutter_test.dart';

import 'package:flog/domain/log_fields/time.dart';

void main() {
  group('Time RegExp tests', () {
    test('"20:02" shall not fail', () {
      expect(timeRE.hasMatch('20:02'), true);
    });
    test('"00:00" shall not fail', () {
      expect(timeRE.hasMatch('00:00'), true);
    });
    test('"23:59" shall not fail', () {
      expect(timeRE.hasMatch('23:59'), true);
    });
    test('"-3:59" shall fail', () {
      expect(timeRE.hasMatch('-3:59'), false);
    });
  });

  group('TimeValidator', () {
    test('00:00 shall not fail', () {
      final validator = TimeValidator('00:00');
      expect(validator.getFailureOrNull(), null);
    });
    test('23:59 shall not fail', () {
      final validator = TimeValidator('23:59');
      expect(validator.getFailureOrNull(), null);
    });
    test('24:00 shall fail', () {
      final validator = TimeValidator('24:00');
      expect(validator.getFailureOrNull(), isA<InvalidTimeFormat>());
    });
    test('00:70 shall fail', () {
      final validator = TimeValidator('00:70');
      expect(validator.getFailureOrNull(), isA<InvalidTimeFormat>());
    });
  });
}