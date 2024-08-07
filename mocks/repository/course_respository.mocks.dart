import 'package:continental_app/domain/models/course_model.dart';
import 'package:continental_app/domain/respositories/respositories.dart';

class CourseRepositoryMock implements CourseRepository {
  bool addCourseWasCalled = false;
  bool addCourseResult = false;
  bool getCoursesWasCalled = false;
  List<CourseModel>? getCoursesResult;
  bool updateCourseWasCalled = false;
  bool updateCourseResult = false;
  bool deleteCourseWasCalled = false;
  bool deleteCourseResult = false;

  @override
  Future<bool> addCourse(Map<String, dynamic> body) async {
    addCourseWasCalled = true;
    return addCourseResult ? addCourseResult : throw Error();
  }

  @override
  Future<List<Object>> getCourses(Map<String, dynamic>? queries) async {
    getCoursesWasCalled = true;
    if (getCoursesResult != null) {
      return getCoursesResult! as List<Object>;
    } else {
      throw Error();
    }
  }

  @override
  Future<bool> updateCourse(String id, Map<String, dynamic> body) async {
    updateCourseWasCalled = true;
    return updateCourseResult ? updateCourseResult : throw Error();
  }

  @override
  Future<bool> deleteCourse(String id) async {
    deleteCourseWasCalled = true;
    return deleteCourseResult ? deleteCourseResult : throw Error();
  }
}
