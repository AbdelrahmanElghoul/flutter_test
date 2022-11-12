import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testiing/bussiness/login_cubt/login_cubit.dart';
import 'package:flutter_testiing/data/repo_interface.dart';

void main() {
  late IRepository repo;

  setUp(() => repo = IRepository.fake());

  group('login method', () {
    test("test future", () async {
      expect(
          await repo.login(
            email: "test@test.com",
            password: "Ab123456",
          ),
          'success');
    });

    test("test future", () async {
      final res = repo.login(
        email: "test@test.com",
        password: "Ab123456",
      );
      expectLater(res, completion('success'));
    });
  });

  group('throw Exception test', () {
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
}
