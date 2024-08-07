import 'package:continental_app/domain/usecase/usecase.dart';

class IsAuthenticatedUseCaseMock implements IsAuthenticatedUseCase {
  bool executeWasCalled = false;
  bool executeResult = false;

  @override
  Future<bool> execute() async {
    executeWasCalled = true;
    return executeResult;
  }
}
