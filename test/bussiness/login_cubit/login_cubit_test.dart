import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/data/fake_repository.mocks.dart';
import 'package:test_flutter/data/model/excception_model/exceptions.dart';
import 'package:test_flutter/data/model/location.dart';
import 'package:test_flutter/data/model/user.dart';
import 'package:test_flutter/data/model/user_address.dart';
import 'package:test_flutter/data/repo_interface.dart';

void main() {
  late LoginCubit loginCubit;
  late IRepository repo;

  setUp(() {
    repo = MockFakeRepository();
    loginCubit = LoginCubit(repo);
  });

  group('login method', () {
    test("login success", () async {
      const User user = User(
        firstName: "first",
        lastName: "last",
        email: "test@test.com",
        address: Address(
          address: "address",
          location: Location(30, 30),
        ),
      );
      when(repo.login(
        email: anyNamed("email"),
        password: anyNamed("password"),
      )).thenAnswer((_) async => user);

      expectLater(
        loginCubit.stream,
        emitsInOrder([
          LoginLoadingState(),
          LoginSuccessState(user),
        ]),
      );

      final res = loginCubit.login(
        email: "any",
        password: "any",
      );
    });

    test("login fail", () async {
      const AuthException exception = AuthException(message: "invalid");
      when(repo.login(
        email: anyNamed("email"),
        password: anyNamed("password"),
      )).thenThrow(exception);

      expectLater(
        loginCubit.stream,
        emitsInOrder([
          LoginLoadingState(),
          LoginErrorState(exception),
        ]),
      );

      final res = loginCubit.login(
        email: "email",
        password: "password",
      );
    });
  });
}
