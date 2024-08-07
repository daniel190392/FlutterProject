import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late CourseRepositoryMock apiCourseRepositoryMock;
  late CourseRepositoryMock dbCourseRepositoryMock;
  late DefaultFetchCoursesUseCase sut;

  setUp(() {
    apiCourseRepositoryMock = CourseRepositoryMock();
    dbCourseRepositoryMock = CourseRepositoryMock();
    sut = DefaultFetchCoursesUseCase(
      apiCourseRepositoryMock,
      dbCourseRepositoryMock,
    );
  });

  final course = CourseModel.newCourse(
    title: 'example',
    category: CategoryCourseModel.web,
  );

  group('Get Courses usecase with API', () {
    test('Execute with success result', () async {
      // GIVEN
      apiCourseRepositoryMock.getCoursesResult = [course];

      // WHEN
      final result = await sut.execute(availableConnection: true);

      // THEN
      expect(result.length, 1);
      expect(apiCourseRepositoryMock.getCoursesWasCalled, true);
      expect(dbCourseRepositoryMock.getCoursesWasCalled, false);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute(availableConnection: true);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.getCoursesWasCalled, true);
        expect(dbCourseRepositoryMock.getCoursesWasCalled, false);
      }
    });
  });

  group('Get Courses usecase with local database', () {
    test('Execute with success result', () async {
      // GIVEN
      dbCourseRepositoryMock.getCoursesResult = [course];

      // WHEN
      final result = await sut.execute(availableConnection: false);

      // THEN
      expect(result.length, 1);
      expect(apiCourseRepositoryMock.getCoursesWasCalled, false);
      expect(dbCourseRepositoryMock.getCoursesWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute(availableConnection: false);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiCourseRepositoryMock.getCoursesWasCalled, false);
        expect(dbCourseRepositoryMock.getCoursesWasCalled, true);
      }
    });
  });
}
