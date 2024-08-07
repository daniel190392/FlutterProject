abstract class CourseRepository {
  Future<bool> addCourse(Map<String, dynamic> body);

  Future<List<Object>> getCourses(Map<String, dynamic>? queries);

  Future<bool> updateCourse(String id, Map<String, dynamic> body);

  Future<bool> deleteCourse(String id);
}
