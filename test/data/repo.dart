import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/data/fake_repository.dart';
import 'package:test_flutter/data/fake_repository.mocks.dart';
import 'package:test_flutter/data/model/errors.dart';
import 'package:test_flutter/data/model/location.dart';
import 'package:test_flutter/data/model/user.dart';
import 'package:test_flutter/data/model/user_address.dart';
import 'package:test_flutter/data/repo_interface.dart';

void main() {
  late IRepository repo;

  setUp(() => repo = IRepository.fake());

  group('success login method', () {
    group(' without fakeAsync', () {
      test("test future1", () async {
        expect(
          await repo.login(
            email: FakeRepository.fakeEmail,
            password: FakeRepository.fakePassword,
          ),
          isA<User>(),
        );
      });

      test("test future2", () async {
        final res = repo.login(
          email: FakeRepository.fakeEmail,
          password: FakeRepository.fakePassword,
        );
        expectLater(res, completion(isA<User>()));
      });
    });

    //------------------- FakeAsync
    // FakeAsync run tests without waiting for futures
    group('fakeAsync', () {
      test("test future", () async {
        fakeAsync((async) {
          expect(
            repo.login(
              email: FakeRepository.fakeEmail,
              password: FakeRepository.fakePassword,
            ),
            completion(isA<User>()),
          );
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("test future - fakeAsync", () {
        fakeAsync((async) {
          final res = repo.login(
            email: FakeRepository.fakeEmail,
            password: FakeRepository.fakePassword,
          );
          expect(res, completion(isA<User>()));
          async.elapse(const Duration(minutes: 1));
        });
      });
    });
  });

  group('throw Exception test', () {
    /// use expect with exception
    /// expect later will make the exception to be thrown without being caught causing test to fail
    group(' without fakeAsync', () {
      test("success exception test1", () {
        expect(
          repo.login(
            email: "x${FakeRepository.fakeEmail}",
            password: "Ab123456",
          ),
          throwsA(isA<AuthException>()),
        );
      });

      test("success exception test2", () {
        final res = repo.login(
          email: "x${FakeRepository.fakeEmail}",
          password: "Ab123456",
        );
        expect(res, throwsA(isA<AuthException>()));
      });

      /// will fail test as the exception will be thrown
      test("failed exception test1", () async {
        final res = repo.login(
          email: "x${FakeRepository.fakeEmail}",
          password: "Ab123456",
        );
        expectLater(res, completion(throwsA(isA<Exception>)));
      });

      test("failed exception test2", () async {
        final res = repo.login(
          email: "x${FakeRepository.fakeEmail}",
          password: "Ab123456",
        );
        expectLater(res, completion(throwsA(isA<Exception>)));
      });
    });
    group('test - fakeAsync', () {
      test("success exception test1", () {
        fakeAsync((async) {
          expect(
            repo.login(
              email: "x${FakeRepository.fakeEmail}",
              password: "Ab123456",
            ),
            throwsA(isA<AuthException>()),
          );
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("success exception test2", () {
        fakeAsync((async) {
          final res = repo.login(
            email: "x${FakeRepository.fakeEmail}",
            password: "Ab123456",
          );
          expect(res, throwsA(isA<AuthException>()));
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("failed exception test1", () async {
        fakeAsync((async) {
          final res = repo.login(
            email: "x${FakeRepository.fakeEmail}",
            password: "Ab123456",
          );
          expect(res, completion(throwsA(isA<AuthException>)));
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("failed exception test2", () async {
        fakeAsync((async) {
          final res = repo.login(
            email: "x${FakeRepository.fakeEmail}",
            password: "Ab123456",
          );
          expect(res, completion(throwsA(isA<AuthException>)));
          async.elapse(const Duration(minutes: 1));
        });
      });
    });
  });

  group("mocking login method", () {
    test('mock', () async {
      var mockedRepo = MockFakeRepository();
      const user = User(
        email: "neMockedEmail",
        lastName: "mockedLast",
        firstName: "mockedFirst",
        address: Address(
          address: "mocked address",
          location: Location(9, 9),
        ),
      );
      when(
        mockedRepo.login(email: "email", password: "password"),
      ).thenAnswer((_) async => user);

      expect(
        await mockedRepo.login(email: "email", password: "password"),
        user,
      );
    });
  });
}
