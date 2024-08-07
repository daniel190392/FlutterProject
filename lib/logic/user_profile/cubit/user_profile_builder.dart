import 'package:http/http.dart';

import '../../../domain/respositories/respositories.dart';
import '../../../domain/usecase/usecase.dart';
import '../../logic.dart';

class UserProfileCubitBuilder {
  static UserProfileCubit builder() {
    UserRepository apiRepository = APIUserProfileRepository(Client());
    UserRepository dbRepository = DBUserProfileRepository();
    GetUserUseCase getUserUseCase = DefaultGetUserUseCase(
      apiRepository,
      dbRepository,
    );
    UpdateUserUseCase updateUserUseCase =
        DefaultUpdateUserUseCase(apiRepository);
    GetUserIdUseCase getUserIdUseCase = DefaultGetUserIdUseCase(
      KeychainAuthenticationRepository(),
    );
    return UserProfileCubit(
      getUserUseCase,
      updateUserUseCase,
      getUserIdUseCase,
    );
  }
}
