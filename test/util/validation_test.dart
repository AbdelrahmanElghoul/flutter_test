import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/data/fake_repository.dart';
import 'package:test_flutter/util/validation.dart';

void main() {
  group('email validation', () {
    group('valid email', () {
      const bool validationResult = true;
      test('fake email is valid', () {
        bool isValid = Validation.email(FakeRepository.fakeEmail);

        expect(isValid, validationResult);
      });

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

  group('password validation', () {
    group('password valid', () {
      const bool validationResult = true;
      test('fake password is valid', () {
        bool isValid = Validation.password(FakeRepository.fakePassword);
        expect(isValid, validationResult);
      });

      test('length is 6 and all numbers', () {
        bool isValid = Validation.password("123456");
        expect(isValid, validationResult);
      });
      test('length is 6 and all chars', () {
        bool isValid = Validation.password("abcdefg");
        expect(isValid, validationResult);
      });
      test('length is 6 and contain chars and numbers', () {
        bool isValid = Validation.password("123abcdefg");
        expect(isValid, validationResult);
      });

      test('length is 6 and contain space in between', () {
        bool isValid = Validation.password("1 2 3 4");
        expect(isValid, validationResult);
      });
    });
    group('password invalid', () {
      const bool validationResult = false;

      test('length is less than 6', () {
        bool isValid = Validation.password("12345");
        expect(isValid, validationResult);
      });
      test('length is 6 and all spaces', () {
        bool isValid = Validation.password("      ");
        expect(isValid, validationResult);
      });
      test('length is 6 and contain chars and white spaces at end', () {
        bool isValid = Validation.password("12345 ");
        expect(isValid, validationResult);
      });
    });
  });
}
