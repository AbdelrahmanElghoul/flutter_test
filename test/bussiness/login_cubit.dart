import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/bussiness/login_cubt/login_cubit.dart';
import 'package:test_flutter/data/fake_repository.dart';
import 'package:test_flutter/data/repo_interface.dart';

void main() {
  late LoginCubit loginCubit;

  setUp(() {
    var repo = IRepository.fake();
    loginCubit = LoginCubit(repo);
  });

  group('login method', () {
    test("description", () async {
      final res = loginCubit.login(
        email: FakeRepository.fakeEmail,
        password: FakeRepository.fakePassword,
      );

      expectLater(res, completion('success'));
    });
  });
}
