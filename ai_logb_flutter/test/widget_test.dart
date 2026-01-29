import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Basic Flutter Tests', () {
    test('simple test example', () {
      expect(2 + 2, equals(4));
    });

    test('string manipulation test', () {
      final String greeting = 'Hello';
      expect(greeting.length, equals(5));
      expect(greeting, contains('Hello'));
    });
  });
}
