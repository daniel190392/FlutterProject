import 'package:continental_app/domain/usecase/usecase.dart';

class SetAuthenticationUseCaseMock implements SetAuthenticationUseCase {
  bool executeWasCalled = false;
  bool executeResult = false;

  @override
  Future<void> execute(bool value) async {
    executeWasCalled = true;
    if (executeResult) {
      return;
    }
    throw Error();
  }
}
