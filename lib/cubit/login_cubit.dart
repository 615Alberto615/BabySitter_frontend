import 'package:bloc/bloc.dart';
import '../service/LoginService.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService _loginService;

  LoginCubit(this._loginService)
      : super(LoginState(isLoading: false, isSuccess: false));

  Future<void> loginUser(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final response = await _loginService.login(email, password);
      print("$response  Cubit");
      final data = response['data'];

      // Aquí puedes realizar cualquier lógica adicional con los datos recibidos

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        userData: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: 'Error al iniciar sesión',
      ));
    }
  }
}
