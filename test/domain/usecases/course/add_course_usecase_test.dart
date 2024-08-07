import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late CourseRepositoryMock apiCourseRepositoryMock;
  late CourseRepositoryMock dbCourseRepositoryMock;
  late DefaultAddCoursesUseCase sut;

  setUp(() {
    apiCourseRepositoryMock = CourseRepositoryMock();
    dbCourseRepositoryMock = CourseRepositoryMock();
    sut = DefaultAddCoursesUseCase(
      apiCourseRepositoryMock,
      dbCourseRepositoryMock,
    );
  });

  final course = CourseModel.newCourse(
    title: 'example',
    category: CategoryCourseModel.web,
  );

  group('Add Course usecase with API', () {
    test('Execute with success result', () async {
      // GIVEN
      apiCourseRepositoryMock.addCourseResult = true;

      // WHEN
      final result = await sut.execute(course, true);

      // THEN
      expect(result, true);
      expect(apiCourseRepositoryMock.addCourseWasCalled, true);
      expect(dbCourseRepositoryMock.addCourseWasCalled, false);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute(course, true);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.addCourseWasCalled, true);
        expect(dbCourseRepositoryMock.addCourseWasCalled, false);
      }
    });
  });

  group('Add Course usecase with local database', () {
    test('Execute with success result', () async {
      // GIVEN
      dbCourseRepositoryMock.addCourseResult = true;

      // WHEN
      final result = await sut.execute(course, false);

      // THEN
      expect(result, true);
      expect(apiCourseRepositoryMock.addCourseWasCalled, false);
      expect(dbCourseRepositoryMock.addCourseWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute(course, false);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.addCourseWasCalled, false);
        expect(dbCourseRepositoryMock.addCourseWasCalled, true);
      }
    });
  });
}
