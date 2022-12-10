import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/bussiness/home_cubit/home_cubit.dart';
import 'package:test_flutter/bussiness/login_cubit/login_cubit.dart';
import 'package:test_flutter/data/repo_interface.dart';
import 'package:test_flutter/presentation/screens/home/home_screen.dart';
import 'package:test_flutter/presentation/screens/login/login_screen.dart';
import 'package:test_flutter/util/consant/pages.dart';

class NavigationRoute {
  NavigationRoute._();

  static NavigationRoute instance = NavigationRoute._();

  final String initRoute = Pages.login;

  Route<Widget>? onGenerateRoute(RouteSettings settings) {
    final repo = IRepository.fake();

    switch (settings.name) {
      case Pages.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(repo),
            child: const LoginScreen(),
          ),
        );

      case Pages.home:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (_) => HomeCubit(repo),
            child: const HomeScreen(),
          );
        });
    }
    return null;
  }
}
