import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/usecase/course/course.dart';
import 'package:continental_app/resources/resources.dart';

class FetchCoursesUseCaseMock implements FetchCoursesUseCase {
  bool executeWasCalled = false;
  List<CourseModel>? executeResult;

  @override
  Future<List<CourseModel>> execute({
    required bool availableConnection,
    Map<String, dynamic>? queries,
  }) async {
    if (executeResult != null) {
      return executeResult!;
    } else {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }
}
