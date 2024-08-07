import 'package:continental_app/domain/usecase/usecase.dart';

class GetUserIdUseCaseMock implements GetUserIdUseCase {
  bool executeWasCalled = false;
  String? executeResult;

  @override
  Future<String> execute() async {
    executeWasCalled = true;
    if (executeResult != null) {
      return executeResult!;
    }
    throw Error();
  }
}
