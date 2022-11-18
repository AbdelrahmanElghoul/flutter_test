part of 'login_cubit.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [runtimeType];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [runtimeType];
}

class LoginErrorState extends LoginState {
  final Object? exception;
  LoginErrorState(this.exception);
  @override
  List<Object?> get props => [exception];
}

class LoginSuccessState extends LoginState {
  final User user;
  LoginSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}
