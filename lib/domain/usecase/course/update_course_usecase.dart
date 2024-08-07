import '../../models/models.dart';
import '../../respositories/course/course.dart';

abstract class UpdateCoursesUseCase {
  Future<bool> execute(
    CourseModel course,
    bool availableConnection,
  );
}

class DefaultUpdateCoursesUseCase implements UpdateCoursesUseCase {
  final CourseRepository _apiRepository;
  final CourseRepository _dbRepository;

  DefaultUpdateCoursesUseCase(apiRepository, dbRepository)
      : _apiRepository = apiRepository,
        _dbRepository = dbRepository;

  @override
  Future<bool> execute(
    CourseModel course,
    bool availableConnection,
  ) {
    return availableConnection
        ? _apiRepository.updateCourse(course.identifier, course.toMap())
        : _dbRepository.updateCourse(course.identifier, course.toMap());
  }
}
