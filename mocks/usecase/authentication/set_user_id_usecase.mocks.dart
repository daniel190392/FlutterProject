import 'package:continental_app/domain/usecase/usecase.dart';

class SetUserIdUseCaseMock implements SetUserIdUseCase {
  bool executeWasCalled = false;
  bool executeResult = false;

  @override
  Future<void> execute(String userId) async {
    executeWasCalled = true;
    if (executeResult) {
      return;
    }
    throw Error();
  }
}
