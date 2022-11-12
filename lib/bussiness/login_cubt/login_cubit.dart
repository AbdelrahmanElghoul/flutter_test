import 'package:bloc/bloc.dart';
import 'package:flutter_testiing/data/repo_interface.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IRepository _repo;
  LoginCubit(this._repo) : super(LoginInitialState());

  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final response = await _repo.login(email: email, password: password);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e));
    }
  }
}
