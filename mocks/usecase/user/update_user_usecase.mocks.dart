import 'package:continental_app/domain/models/user_model.dart';
import 'package:continental_app/domain/usecase/usecase.dart';

class UpdateUserUseCaseMock implements UpdateUserUseCase {
  bool executeWasCalled = false;
  bool executeResult = false;

  @override
  Future<bool> execute(String userId, UserModel user) async {
    executeWasCalled = true;
    return executeResult ? executeResult : throw Error();
  }
}
