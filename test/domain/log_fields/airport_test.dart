import 'package:flutter_test/flutter_test.dart';

import 'package:flog/domain/log_fields/airport.dart';

void main() {
  group('Airport constructor', () {

    test('IATA coded Airport should be constructed with 3 letters', () {
      final airport = Airport.fromIATA('ORY');
      expect(airport.isValid, true);
      var invalidAirport = Airport.fromIATA('LFPO');
      expect(invalidAirport.isFailed, true);
      invalidAirport = Airport.fromIATA('1234');
      expect(invalidAirport.isFailed, true);
    });

    test('ICAO coded Airport should be constructed with 4 letters', () {
      final invalidAirport = Airport.fromICAO('ORY');
      expect(invalidAirport.isValid, false);
      final airport = Airport.fromICAO('LFPO');
      expect(airport.isFailed, false);
    });
  });
}