import 'package:flutter_test/flutter_test.dart';

// This is a simple unit test example
void main() {
  group('String utilities', () {
    test('String capitalization works correctly', () {
      // Given
      const input = 'hello';

      // When
      final result = input[0].toUpperCase() + input.substring(1);

      // Then
      expect(result, equals('Hello'));
    });

    test('String concatenation works correctly', () {
      // Given
      const a = 'Hello';
      const b = 'World';

      // When
      final result = '$a $b';

      // Then
      expect(result, equals('Hello World'));
    });
  });
}
