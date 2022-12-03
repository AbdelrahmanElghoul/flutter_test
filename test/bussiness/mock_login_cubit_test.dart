import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/bussiness/login_cubt/login_cubit.dart';

class MockLoginBloc extends MockBloc<LoginCubit, LoginState>
    implements LoginCubit {}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  late LoginCubit loginCubit;

  setUp(() {
    loginCubit = MockLoginBloc();
  });

  group("mock loginCubit", () {
    test('mock emit all', () async {
      whenListen(
        loginCubit,
        Stream.fromIterable(
          [
            LoginLoadingState(),
            LoginErrorState(null),
          ],
        ),
        initialState: LoginInitialState(),
      );
      await expectLater(
        loginCubit.stream,
        emitsInOrder(
          [LoginLoadingState(), LoginErrorState(null)],
        ),
      );
    });

    test('mock emit loading only', () async {
      whenListen(
        loginCubit,
        Stream.fromIterable(
          [
            LoginLoadingState(),
            LoginErrorState(null),
          ],
        ),
        initialState: LoginInitialState(),
      );
      await expectLater(
        loginCubit.stream,
        emitsInOrder(
          [LoginLoadingState()],
        ),
      );
    });
  });
}
