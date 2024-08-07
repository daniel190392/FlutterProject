import 'package:bloc/bloc.dart';
import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:continental_app/resources/resources.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  SetAuthenticationUseCase setAuthenticationUseCase;
  SetUserIdUseCase setUserIdUseCase;
  final userId = '653c20ac96680964f7286ccb';

  LoginCubit(
    this.setAuthenticationUseCase,
    this.setUserIdUseCase,
  ) : super(LoginInitial());

  void emitLogin() async {
    try {
      emit(LoginLoading());
      await setUserIdUseCase.execute(userId);
      await setAuthenticationUseCase.execute(true);
      emit(LoginLoaded());
    } catch (_) {
      emit(LoginError());
    }
  }
}
