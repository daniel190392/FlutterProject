import '../../../domain/respositories/respositories.dart';
import '../../../domain/usecase/usecase.dart';
import '../../logic.dart';

class LoginCubitBuilder {
  static LoginCubit builder() {
    SetAuthenticationUseCase setAuthenticationUseCase =
        DefaultSetAuthenticationUseCase(
      SharedPreferenceAuthenticationRepository(),
    );
    SetUserIdUseCase setUserIdUseCase = DefaultSetUserIdUseCase(
      KeychainAuthenticationRepository(),
    );
    return LoginCubit(setAuthenticationUseCase, setUserIdUseCase);
  }
}
