import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/data/fake_repository.dart';
import 'package:test_flutter/data/repo_interface.dart';

void main() {
  late IRepository repo;

  setUp(() => repo = IRepository.fake());

  group('success login method', () {
    group(' without fakeAsync', () {
      test("test future", () async {
        expect(
            await repo.login(
              email: FakeRepository.fakeEmail,
              password: FakeRepository.fakePassword,
            ),
            'success');
      });

      test("test future", () async {
        final res = repo.login(
          email: FakeRepository.fakeEmail,
          password: FakeRepository.fakePassword,
        );
        expectLater(res, completion('success'));
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
              completion('success'));
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("test future - fakeAsync", () {
        fakeAsync((async) {
          final res = repo.login(
            email: FakeRepository.fakeEmail,
            password: FakeRepository.fakePassword,
          );
          expect(res, completion('success'));
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
              email: "test0@test.com",
              password: "Ab123456",
            ),
            throwsException);
      });

      test("success exception test2", () async {
        final res = repo.login(
          email: "test2@test.com",
          password: "Ab123456",
        );
        expect(res, throwsException);
      });

      /// will fail test as the exception will be thrown
      test("failed exception test1", () async {
        final res = repo.login(
          email: "test1@test.com",
          password: "Ab123456",
        );
        expectLater(res, completion(throwsA(isA<Exception>)));
      });

      test("failed exception test2", () async {
        final res = repo.login(
          email: "test1@test.com",
          password: "Ab123456",
        );
        expectLater(res, completion(throwsException));
      });
    });
    group('test - fakeAsync', () {
      test("success exception test1", () {
        fakeAsync((async) {
          expect(
            repo.login(
              email: "test0@test.com",
              password: "Ab123456",
            ),
            throwsException,
          );
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("success exception test2", () async {
        fakeAsync((async) {
          final res = repo.login(
            email: "test2@test.com",
            password: "Ab123456",
          );
          expect(res, throwsException);
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("failed exception test1", () async {
        fakeAsync((async) {
          final res = repo.login(
            email: "test1@test.com",
            password: "Ab123456",
          );
          expect(res, completion(throwsA(isA<Exception>)));
          async.elapse(const Duration(minutes: 1));
        });
      });

      test("failed exception test2", () async {
        fakeAsync((async) {
          final res = repo.login(
            email: "test1@test.com",
            password: "Ab123456",
          );
          expect(res, completion(throwsException));
          async.elapse(const Duration(minutes: 1));
        });
      });
    });
  });
}
