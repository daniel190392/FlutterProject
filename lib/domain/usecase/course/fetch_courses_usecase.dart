import 'dart:math';

import '../../models/models.dart';
import '../../respositories/course/course.dart';

abstract class FetchCoursesUseCase {
  Future<List<CourseModel>> execute({
    required bool availableConnection,
    Map<String, dynamic>? queries,
  });
}

class DefaultFetchCoursesUseCase implements FetchCoursesUseCase {
  final CourseRepository _apiRepository;
  final CourseRepository _bdRepository;

  DefaultFetchCoursesUseCase(apiRepository, bdRepository)
      : _apiRepository = apiRepository,
        _bdRepository = bdRepository;

  @override
  Future<List<CourseModel>> execute({
    required bool availableConnection,
    Map<String, dynamic>? queries,
  }) async {
    if (availableConnection) {
      final courses =
          await _apiRepository.getCourses(queries) as List<CourseModel>;
      await _clearTable(_bdRepository);
      await _insertCoursesOnLocal(courses, _bdRepository);
      return courses;
    } else {
      final courses = await _bdRepository.getCourses(queries);
      return courses as List<CourseModel>;
    }
  }

  Future<void> _clearTable(
    CourseRepository repository,
  ) async {
    try {
      final courses = await _bdRepository.getCourses(null) as List<CourseModel>;
      for (var element in courses) {
        await repository.deleteCourse(element.identifier);
      }
    } catch (_) {
      return;
    }
  }

  Future<void> _insertCoursesOnLocal(
    List<CourseModel> courses,
    CourseRepository repository,
  ) async {
    try {
      for (var element in courses) {
        await repository.addCourse(element.toMap());
      }
      return;
    } catch (_) {
      return;
    }
  }
}
