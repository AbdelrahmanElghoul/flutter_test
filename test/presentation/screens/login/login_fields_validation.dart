import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/presentation/common/loading_widget.dart';
import 'package:test_flutter/presentation/screens/login/login_screen.dart';
import 'package:test_flutter/util/consant/const_text.dart';

void main() {
  /// setting environment
  const String validEmail = "test@test.com";
  const String validPassword = "Aa123456";
  const emailKey = ValueKey("emailKey");
  const passwordKey = ValueKey("passwordKey");
  const loginBtnKey = ValueKey("loginBtnKey");

  testWidgets('testing email validation appear successfully',
      (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    /// all elements exists
    expect(find.byKey(emailKey), findsOneWidget);
    expect(find.byKey(passwordKey), findsOneWidget);
    expect(find.byKey(loginBtnKey), findsOneWidget);
    expect(find.byType(LoadingWidget), findsNothing);

    /// enter text
    await widgetTester.enterText(find.byKey(emailKey), "1234");
    await widgetTester.enterText(find.byKey(passwordKey), validPassword);

    await widgetTester.tap(find.byKey(loginBtnKey));
    await widgetTester.pump();
    expect(find.text(Messages.invalidEmail), findsOneWidget);
    expect(find.text(Messages.invalidPassword), findsNothing);
  });

  testWidgets('testing password validation appear successfully',
      (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    /// all elements exists
    expect(find.byKey(emailKey), findsOneWidget);
    expect(find.byKey(passwordKey), findsOneWidget);
    expect(find.byKey(loginBtnKey), findsOneWidget);
    expect(find.byType(LoadingWidget), findsNothing);

    /// enter text
    await widgetTester.enterText(find.byKey(emailKey), validEmail);
    await widgetTester.enterText(find.byKey(passwordKey), '1');

    await widgetTester.tap(find.byKey(loginBtnKey));
    await widgetTester.pump();
    expect(find.text(Messages.invalidEmail), findsNothing);
    expect(find.text(Messages.invalidPassword), findsOneWidget);
  });

  testWidgets('testing both email/password validation appear successfully',
      (widgetTester) async {
    await widgetTester.pumpWidget(createWidgetUnderTest());

    /// all elements exists
    expect(find.byKey(emailKey), findsOneWidget);
    expect(find.byKey(passwordKey), findsOneWidget);
    expect(find.byKey(loginBtnKey), findsOneWidget);
    expect(find.byType(LoadingWidget), findsNothing);

    /// enter text
    await widgetTester.enterText(find.byKey(emailKey), '');
    await widgetTester.enterText(find.byKey(passwordKey), '1');

    await widgetTester.tap(find.byKey(loginBtnKey));
    await widgetTester.pump();
    expect(find.text(Messages.invalidEmail), findsOneWidget);
    expect(find.text(Messages.invalidPassword), findsOneWidget);
  });
}

createWidgetUnderTest() {
  return MaterialApp(
    home: BlocProvider(
      create: (_) => LoginCubit(),
      child: const LoginScreen(),
    ),
  );
}
