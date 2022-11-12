part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final Object? exception;
  LoginErrorState([this.exception]);
}

class LoginSuccessState extends LoginState {}
