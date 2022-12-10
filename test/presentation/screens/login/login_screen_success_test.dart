import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter/bussiness/home_cubit/home_cubit.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/data/fake_repository.mocks.dart';
import 'package:test_flutter/data/model/location.dart';
import 'package:test_flutter/data/model/user.dart';
import 'package:test_flutter/data/model/user_address.dart';
import 'package:test_flutter/presentation/screens/home/home_screen.dart';
import 'package:test_flutter/presentation/screens/login/login_screen.dart';
import 'package:test_flutter/util/consant/pages.dart';

void main() {
  testWidgets('testing login success components', (widgetTester) async {
    /// setting environment
    const String email = "test@test.com";
    const String password = "Aa123456";
    final repo = MockFakeRepository();
    LoginCubit loginCubit = LoginCubit(repo);
    const emailKey = ValueKey("emailKey");
    const passwordKey = ValueKey("passwordKey");
    const loginBtnKey = ValueKey("loginBtnKey");

    const User user = User(
      firstName: "first",
      lastName: "last",
      email: "test@test.com",
      address: Address(
        address: "address",
        location: Location(30, 30),
      ),
    );

    /// creating widget
    await widgetTester.pumpWidget(createWidgetUnderTest(loginCubit));

    /// mocking repo
    when(
      repo.login(
        email: anyNamed("email"),
        password: anyNamed("password"),
      ),
    ).thenAnswer((_) async => user);

    /// testing cubit
    expectLater(
      loginCubit.stream,
      emitsInOrder([
        LoginLoadingState(),
        LoginSuccessState(user),
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
    await widgetTester.pumpAndSettle();

    /// test success message appeared on screen
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}

createWidgetUnderTest(LoginCubit loginCubit) {
  return MaterialApp(
    onGenerateRoute: (setting) {
      switch (setting.name) {
        case Pages.login:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => loginCubit,
              child: const LoginScreen(),
            ),
          );

        case Pages.home:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => HomeCubit(null),
              child: const HomeScreen(),
            ),
          );
      }
    },
    initialRoute: Pages.login,
  );
}
