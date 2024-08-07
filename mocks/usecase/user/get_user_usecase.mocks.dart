import 'package:continental_app/domain/models/user_model.dart';
import 'package:continental_app/domain/usecase/usecase.dart';

class GetUserUseCaseMock implements GetUserUseCase {
  bool executeWasCalled = false;
  UserModel? executeResult;

  @override
  Future<UserModel> execute(
    String userId,
    bool availableConnection,
  ) async {
    executeWasCalled = true;
    if (executeResult != null) {
      return executeResult!;
    }
    throw Error();
  }
}
