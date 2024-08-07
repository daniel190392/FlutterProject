import 'package:continental_app/domain/models/course_model.dart';
import 'package:continental_app/domain/usecase/course/course.dart';

class UpdateCoursesUseCaseMock implements UpdateCoursesUseCase {
  bool executeWasCalled = false;
  bool executeResult = false;

  @override
  Future<bool> execute(CourseModel course, bool availableConnection) async {
    executeWasCalled = true;
    return executeResult ? executeResult : throw Error();
  }
}
