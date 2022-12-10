part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitState extends HomeState {
  const HomeInitState();

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  final List<User> users;

  const HomeSuccessState(this.users);

  @override
  List<Object?> get props => [users];
}

class HomeErrorState extends HomeState {
  final BaseException exception;

  const HomeErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}
