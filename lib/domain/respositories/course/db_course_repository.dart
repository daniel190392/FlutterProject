import '../../../resources/contanst.dart';
import '../../models/models.dart';
import '../continental_data_base.dart';
import 'course_repository.dart';

class DBCourseRepository implements CourseRepository {
  final ContinentalDataBase dataBaseProvider;

  DBCourseRepository({ContinentalDataBase? dataBaseProvider})
      : dataBaseProvider =
            dataBaseProvider ?? ContinentalDataBase.dataBaseProvider;

  @override
  Future<bool> addCourse(Map<String, dynamic> body) async {
    try {
      final database = await dataBaseProvider.database;
      await database.insert(ContinentalDataBase.courseTable, body);
      return true;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<List<Object>> getCourses(Map<String, dynamic>? queries) async {
    try {
      final database = await dataBaseProvider.database;
      final jsonList = await database.query(ContinentalDataBase.courseTable);
      return jsonList.map((item) => CourseModel.fromMap(item)).toList();
    } on ArgumentError {
      throw ErrorServiceModel(ErrorCode.parseError.message);
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<bool> updateCourse(String id, Map<String, dynamic> body) async {
    try {
      final database = await dataBaseProvider.database;
      await database.update(
        ContinentalDataBase.courseTable,
        body,
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }

  @override
  Future<bool> deleteCourse(String id) async {
    try {
      final database = await dataBaseProvider.database;
      await database.delete(
        ContinentalDataBase.courseTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } catch (exception) {
      throw ErrorServiceModel(ErrorCode.genericError.message);
    }
  }
}
