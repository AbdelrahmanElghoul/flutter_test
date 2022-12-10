import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/presentation/common/loading_widget.dart';
import 'package:test_flutter/presentation/screens/login/login_screen.dart';

//-------
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  testWidgets('testing loading state', (widgetTester) async {
    /// setting environment
    LoginCubit loginCubit = MockLoginCubit();
    const emailKey = ValueKey("emailKey");
    const passwordKey = ValueKey("passwordKey");
    const loginBtnKey = ValueKey("loginBtnKey");

    /// stub cubit
    whenListen(
      loginCubit,
      Stream<LoginState>.fromIterable([
        LoginLoadingState(),
      ]),
      initialState: LoginLoadingState(),
    );

    /// creating widget
    await widgetTester.pumpWidget(createWidgetUnderTest(loginCubit));

    /// button disappear and loader appear instead
    expect(find.byKey(emailKey), findsOneWidget);
    expect(find.byKey(passwordKey), findsOneWidget);
    expect(find.byKey(loginBtnKey), findsNothing);
    expectLater(find.byType(LoadingWidget), findsOneWidget);
  });
}

createWidgetUnderTest(LoginCubit loginCubit) {
  return MaterialApp(
    home: BlocProvider(
      create: (_) => loginCubit,
      child: const LoginScreen(),
    ),
  );
}
