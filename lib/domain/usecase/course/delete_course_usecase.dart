import '../../respositories/course/course.dart';

abstract class DeleteCoursesUseCase {
  Future<bool> execute(
    String identifier,
    bool availableConnection,
  );
}

class DefaultDeleteCoursesUseCase implements DeleteCoursesUseCase {
  final CourseRepository _apiRepository;
  final CourseRepository _dbRepository;

  DefaultDeleteCoursesUseCase(apiRepository, dbRepository)
      : _apiRepository = apiRepository,
        _dbRepository = dbRepository;

  @override
  Future<bool> execute(
    String identifier,
    bool availableConnection,
  ) {
    return availableConnection
        ? _apiRepository.deleteCourse(identifier)
        : _dbRepository.deleteCourse(identifier);
  }
}
