import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/data/fake_repository.mocks.dart';
import 'package:test_flutter/data/model/excception_model/exceptions.dart';
import 'package:test_flutter/presentation/screens/login_screen.dart';

void main() {
  testWidgets('testing login error components', (widgetTester) async {
    /// setting environment
    const String email = "test@test.com";
    const String password = "Aa123456";
    final repo = MockFakeRepository();
    LoginCubit loginCubit = LoginCubit(repo);
    const emailKey = ValueKey("emailKey");
    const passwordKey = ValueKey("passwordKey");
    const loginBtnKey = ValueKey("loginBtnKey");

    const authException = AuthException(message: 'message');

    /// creating widget
    await widgetTester.pumpWidget(createWidgetUnderTest(loginCubit));

    /// mocking repo
    when(
      repo.login(
        email: anyNamed("email"),
        password: anyNamed("password"),
      ),
    ).thenThrow(authException);

    /// testing cubit
    expectLater(
      loginCubit.stream,
      emitsInOrder([
        LoginLoadingState(),
        LoginErrorState(authException),
      ]),
    );

    /// all elements exists
    expect(find.byKey(emailKey), findsOneWidget);
    expect(find.byKey(passwordKey), findsOneWidget);
    expect(find.byKey(loginBtnKey), findsOneWidget);

    /// no text entered yet
    expect(find.text(email), findsNothing);
    expect(find.text(password), findsNothing);

    /// enter text
    await widgetTester.enterText(find.byKey(emailKey), email);
    await widgetTester.enterText(find.byKey(passwordKey), password);

    /// text entered successfully
    expect(find.text(email), findsOneWidget);
    expect(find.text(password), findsOneWidget);

    /// press the button to start login process

    await widgetTester.tap(find.byKey(loginBtnKey));

    await widgetTester.pump();

    /// test error message appeared on screen
    expect(find.text(authException.toString()), findsOneWidget);

    /// test email field value remains while password cleared
    expect(find.text(email), findsOneWidget);
    expect(find.text(password), findsNothing);
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
