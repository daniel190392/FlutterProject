import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late CourseRepositoryMock apiCourseRepositoryMock;
  late CourseRepositoryMock dbCourseRepositoryMock;
  late DefaultDeleteCoursesUseCase sut;

  setUp(() {
    apiCourseRepositoryMock = CourseRepositoryMock();
    dbCourseRepositoryMock = CourseRepositoryMock();
    sut = DefaultDeleteCoursesUseCase(
      apiCourseRepositoryMock,
      dbCourseRepositoryMock,
    );
  });

  group('Update Course usecase with API', () {
    test('Execute with success result', () async {
      // GIVEN
      apiCourseRepositoryMock.deleteCourseResult = true;

      // WHEN
      final result = await sut.execute('', true);

      // THEN
      expect(result, true);
      expect(apiCourseRepositoryMock.deleteCourseWasCalled, true);
      expect(dbCourseRepositoryMock.deleteCourseWasCalled, false);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute('', true);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.deleteCourseWasCalled, true);
        expect(dbCourseRepositoryMock.deleteCourseWasCalled, false);
      }
    });
  });

  group('Update Course usecase with local database', () {
    test('Execute with success result', () async {
      // GIVEN
      dbCourseRepositoryMock.deleteCourseResult = true;

      // WHEN
      final result = await sut.execute('', false);

      // THEN
      expect(result, true);
      expect(apiCourseRepositoryMock.deleteCourseWasCalled, false);
      expect(dbCourseRepositoryMock.deleteCourseWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute('', false);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.deleteCourseWasCalled, false);
        expect(dbCourseRepositoryMock.deleteCourseWasCalled, true);
      }
    });
  });
}
