import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late CourseRepositoryMock apiCourseRepositoryMock;
  late CourseRepositoryMock dbCourseRepositoryMock;
  late DefaultUpdateCoursesUseCase sut;

  setUp(() {
    apiCourseRepositoryMock = CourseRepositoryMock();
    dbCourseRepositoryMock = CourseRepositoryMock();
    sut = DefaultUpdateCoursesUseCase(
      apiCourseRepositoryMock,
      dbCourseRepositoryMock,
    );
  });

  final course = CourseModel.newCourse(
    title: 'example',
    category: CategoryCourseModel.web,
  );

  group('Update Course usecase with API', () {
    test('Execute with success result', () async {
      // GIVEN
      apiCourseRepositoryMock.updateCourseResult = true;

      // WHEN
      final result = await sut.execute(course, true);

      // THEN
      expect(result, true);
      expect(apiCourseRepositoryMock.updateCourseWasCalled, true);
      expect(dbCourseRepositoryMock.updateCourseWasCalled, false);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute(course, true);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.updateCourseWasCalled, true);
        expect(dbCourseRepositoryMock.updateCourseWasCalled, false);
      }
    });
  });

  group('Update Course usecase with local database', () {
    test('Execute with success result', () async {
      // GIVEN
      dbCourseRepositoryMock.updateCourseResult = true;

      // WHEN
      final result = await sut.execute(course, false);

      // THEN
      expect(result, true);
      expect(apiCourseRepositoryMock.updateCourseWasCalled, false);
      expect(dbCourseRepositoryMock.updateCourseWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute(course, false);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.updateCourseWasCalled, false);
        expect(dbCourseRepositoryMock.updateCourseWasCalled, true);
      }
    });
  });
}
