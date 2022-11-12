import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/util/validation.dart';

void main() {
  group('email validation', () {
    group('valid email', () {
      const bool validationResult = true;
      test('all chars', () {
        bool isValid = Validation.email('test@test.co');

        expect(isValid, validationResult);
      });

      test('contain chars and number (start with char)', () {
        bool isValid = Validation.email('test123@test.co');

        expect(isValid, validationResult);
      });
      test('contain chars and number (start with char)', () {
        bool isValid = Validation.email('test123@test.co');

        expect(isValid, validationResult);
      });
    });

    group('invalid email', () {
      const bool validationResult = false;
      test('contain chars and number (start with number)', () {
        bool isValid = Validation.email('0test123@test.co');

        expect(isValid, validationResult);
      });

      test('only numbers', () {
        bool isValid = Validation.email('0test123@test.co');

        expect(isValid, validationResult);
      });

      test('text', () {
        bool isValid = Validation.email('0test123co');

        expect(isValid, validationResult);
      });

      test('text with @', () {
        bool isValid = Validation.email('0test123co@');

        expect(isValid, validationResult);
      });

      test('text with @', () {
        bool isValid = Validation.email('0test12@3c@o');

        expect(isValid, validationResult);
      });

      test('single char email', () {
        bool isValid = Validation.email('t@test.com');

        expect(isValid, validationResult);
      });
    });
  });
}
