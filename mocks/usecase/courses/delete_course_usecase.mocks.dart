import 'package:continental_app/domain/models/error_service_model.dart';
import 'package:continental_app/domain/usecase/course/course.dart';
import 'package:continental_app/resources/resources.dart';

class DeleteCoursesUseCaseMock implements DeleteCoursesUseCase {
  bool executeWasCalled = false;
  bool executeResult = false;

  @override
  Future<bool> execute(String identifier, bool availableConnection) async {
    executeWasCalled = true;
    return executeResult
        ? executeResult
        : throw ErrorServiceModel(ErrorCode.genericError.message);
  }
}
