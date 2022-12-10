import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/presentation/common/loading_widget.dart';
import 'package:test_flutter/presentation/screens/login_screen.dart';

//-------
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  testWidgets('testing button will be replaced with loader while loading',
      (widgetTester) async {
    /// setting environment
    const String email = "test@test.com";
    const String password = "Aa123456";

    const emailKey = ValueKey("emailKey");
    const passwordKey = ValueKey("passwordKey");
    const loginBtnKey = ValueKey("loginBtnKey");

    /// stream to stubbing cubit states
    StreamController<LoginState> streamController = StreamController();

    /// mocking cubit
    LoginCubit loginCubit = MockLoginCubit();

    /// stub cubit
    when(() => loginCubit.stream).thenAnswer((_) => streamController.stream);
    whenListen(
      loginCubit,
      streamController.stream,
      initialState: LoginInitialState(),
    );

    /// creating widget
    await widgetTester.pumpWidget(createWidgetUnderTest(loginCubit));

    /// all elements exists
    expect(find.byKey(emailKey), findsOneWidget);
    expect(find.byKey(passwordKey), findsOneWidget);
    expect(find.byKey(loginBtnKey), findsOneWidget);
    expect(find.byType(LoadingWidget), findsNothing);

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

    /// setting state value
    streamController.add(LoginLoadingState());

    /// refresh UI
    await widgetTester.pump();

    /// testing if btn was replaced with loader
    expect(find.byKey(emailKey), findsOneWidget);
    expect(find.byKey(passwordKey), findsOneWidget);
    expect(find.byKey(loginBtnKey), findsNothing);
    expect(find.byType(LoadingWidget), findsOneWidget);
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
