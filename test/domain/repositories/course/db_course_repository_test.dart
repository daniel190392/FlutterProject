import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/respositories/continental_data_base.dart';
import 'package:continental_app/domain/respositories/respositories.dart';
import 'package:continental_app/resources/resources.dart';
import 'package:test/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DBCourseRepository sut;
  late ContinentalDataBase dataBaseProvider;
  late Database dataBase;

  setUp(() {
    return Future(() async {
      sqfliteFfiInit();
      dataBase = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      dataBaseProvider = ContinentalDataBase.withDatabase(dataBase);
      await dataBaseProvider.onCreate(dataBase, 1);
      sut = DBCourseRepository(dataBaseProvider: dataBaseProvider);
    });
  });

  tearDown(() {
    dataBase.close();
  });

  Future<List<CourseModel>> getCourses() async {
    final jsonList = await dataBase.query(ContinentalDataBase.courseTable);
    return jsonList.map((item) => CourseModel.fromMap(item)).toList();
  }

  group('Course Table', () {
    test('Get Course with database closed', () async {
      // WHEN
      try {
        await dataBase.close();
        await sut.getCourses(null);
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
      }
    });

    test('Add Course', () async {
      // GIVEN
      final course = CourseModel.newCourse(
          title: 'IOS', category: CategoryCourseModel.mobile);
      // WHEN
      final result = await sut.addCourse(course.toMap());
      final dataFromBD = await getCourses();
      // THEN
      expect(result, true);
      expect(course, dataFromBD.first);
    });

    test('Add Course with database closed', () async {
      // GIVEN
      final course = CourseModel.newCourse(
          title: 'IOS', category: CategoryCourseModel.mobile);
      // WHEN
      try {
        await dataBase.close();
        await sut.addCourse(course.toMap());
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
      }
    });

    test('Update Course', () async {
      // GIVEN
      final course = CourseModel.newCourse(
          title: 'IOS', category: CategoryCourseModel.mobile);
      await sut.addCourse(course.toMap());
      // WHEN
      final newCourse = course.copyWith(title: 'ANDROID');
      final result = await sut.updateCourse(
        course.identifier,
        newCourse.toMap(),
      );
      final dataFromBD = await getCourses();
      // THEN
      expect(result, true);
      expect(newCourse, dataFromBD.first);
    });

    test('Update Course with database closed', () async {
      // GIVEN
      final course = CourseModel.newCourse(
          title: 'IOS', category: CategoryCourseModel.mobile);
      await sut.addCourse(course.toMap());
      // WHEN
      try {
        await dataBase.close();
        final newCourse = course.copyWith(title: 'ANDROID');
        await sut.updateCourse(
          course.identifier,
          newCourse.toMap(),
        );
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
      }
    });

    test('Delete Course', () async {
      // GIVEN
      final course = CourseModel.newCourse(
        title: 'IOS',
        category: CategoryCourseModel.mobile,
      );
      await sut.addCourse(course.toMap());
      // WHEN
      final courses = await getCourses();
      final result = await sut.deleteCourse(course.identifier);
      final coursesBeforeDelete = await getCourses();
      // THEN
      expect(course, courses.first);
      expect(result, true);
      expect(coursesBeforeDelete.isEmpty, true);
    });

    test('Delete Course with database closed', () async {
      // GIVEN
      final course = CourseModel.newCourse(
        title: 'IOS',
        category: CategoryCourseModel.mobile,
      );
      await sut.addCourse(course.toMap());
      // WHEN
      try {
        await dataBase.close();
        await sut.deleteCourse(course.identifier);
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
      }
    });
  });
}
