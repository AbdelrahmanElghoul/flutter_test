import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/data/model/excception_model/exceptions.dart';
import 'package:test_flutter/data/model/user.dart';
import 'package:test_flutter/data/repo_interface.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IRepository? _repo;

  HomeCubit(this._repo) : super(const HomeInitState());

  getUsers() async {
    emit(HomeLoadingState());

    try {
      final users = await _repo?.getUsers();
      emit(HomeSuccessState(users));
    } on BaseException catch (e) {
      emit(HomeErrorState(e));
    } catch (e) {
      emit(HomeErrorState(UnknownException(e)));
    }
  }
}
