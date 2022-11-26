import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/bussiness/login_cubt/login_cubit.dart';

class MockCounterBloc extends MockBloc<LoginCubit, LoginState>
    implements LoginCubit {}

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  late LoginCubit loginCubit;

  setUp(() {
    loginCubit = MockLoginCubit();
  });

  group("mock loginCubit", () {
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
