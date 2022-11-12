import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bussiness/login_cubt/login_cubit.dart';
import 'package:test_flutter/data/repo_interface.dart';
import 'package:test_flutter/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final repo = IRepository.fake();
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => LoginCubit(repo))],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
