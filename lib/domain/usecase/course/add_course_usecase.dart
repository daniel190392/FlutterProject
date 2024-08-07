import '../../models/models.dart';
import '../../respositories/course/course.dart';

abstract class AddCoursesUseCase {
  Future<bool> execute(
    CourseModel course,
    bool availableConnection,
  );
}

class DefaultAddCoursesUseCase implements AddCoursesUseCase {
  final CourseRepository _apiRepository;
  final CourseRepository _dbRepository;

  DefaultAddCoursesUseCase(apiRepository, dbRepository)
      : _apiRepository = apiRepository,
        _dbRepository = dbRepository;

  @override
  Future<bool> execute(
    CourseModel course,
    bool availableConnection,
  ) {
    return availableConnection
        ? _apiRepository.addCourse(course.toMap())
        : _dbRepository.addCourse(course.toMap());
  }
}
