import 'package:continental_app/domain/models/category_course_model.dart';
import 'package:continental_app/domain/models/course_model.dart';
import 'package:continental_app/logic/logic.dart';
import 'package:continental_app/resources/resources.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../mocks/mocks.dart';

void main() {
  late FetchCoursesUseCaseMock fetchCoursesUseCaseMock;
  late DeleteCoursesUseCaseMock deleteCoursesUseCaseMock;
  late IsAuthenticatedUseCaseMock isAuthenticatedUseCaseMock;
  late CoursesCubit coursesCubit;
  final courseDummy = CourseModel.newCourse(
    title: 'title',
    category: CategoryCourseModel.web,
  );

  setUp(() {
    fetchCoursesUseCaseMock = FetchCoursesUseCaseMock();
    deleteCoursesUseCaseMock = DeleteCoursesUseCaseMock();
    isAuthenticatedUseCaseMock = IsAuthenticatedUseCaseMock();
    coursesCubit = CoursesCubit(
      fetchCoursesUseCaseMock,
      deleteCoursesUseCaseMock,
      isAuthenticatedUseCaseMock,
    );
  });

  group('The cubit should emit a AuthenticateUser()', () {
    blocTest(
      'Is Authenticated',
      setUp: () {
        isAuthenticatedUseCaseMock.executeResult = true;
        fetchCoursesUseCaseMock.executeResult = [courseDummy];
      },
      build: () => coursesCubit,
      act: (cubit) => cubit.emitAuthenticateUser(true),
      expect: () => [
        CoursesLoading(),
        CoursesLoaded([courseDummy]),
      ],
    );

    blocTest(
      'Not Authenticated',
      build: () => coursesCubit,
      act: (cubit) => cubit.emitAuthenticateUser(true),
      expect: () => [
        CoursesLoginModal(),
      ],
      verify: (_) {
        expect(isAuthenticatedUseCaseMock.executeWasCalled, true);
      },
    );
  });

  group('The cubit should emit a CoursesLoaded()', () {
    blocTest(
      'Success',
      setUp: () {
        fetchCoursesUseCaseMock.executeResult = [courseDummy];
      },
      build: () => coursesCubit,
      act: (cubit) => cubit.emitFetchCourses(true),
      expect: () => [
        CoursesLoading(),
        CoursesLoaded([courseDummy]),
      ],
    );

    blocTest(
      'Failed',
      build: () => coursesCubit,
      act: (cubit) => cubit.emitFetchCourses(true),
      expect: () => [
        CoursesLoading(),
        CoursesError(ErrorCode.genericError.message),
      ],
    );
  });

  group('The cubit should emit a CourseSelected()', () {
    blocTest(
      'when select course',
      build: () => coursesCubit,
      act: (cubit) => cubit.emitSelectedCourse(const CourseModel(
        identifier: 'identifier',
        title: 'title',
        category: CategoryCourseModel.web,
      )),
      expect: () => [
        CourseSelected(
          const CourseModel(
            identifier: 'identifier',
            title: 'title',
            category: CategoryCourseModel.web,
          ),
          false,
        )
      ],
    );

    blocTest(
      'when is new course',
      setUp: () {
        uuidGenerated = GeneratorUuid(identifier: '0');
      },
      build: () => coursesCubit,
      act: (cubit) => cubit.emitNewCourse(),
      expect: () => [
        CourseSelected(
          const CourseModel(
            identifier: '0',
            title: '',
            category: CategoryCourseModel.web,
          ),
          true,
        )
      ],
    );
  });

  group('The cubit should emit a CourseDeleted()', () {
    blocTest(
      'Success',
      setUp: () {
        deleteCoursesUseCaseMock.executeResult = true;
        fetchCoursesUseCaseMock.executeResult = [courseDummy];
      },
      build: () => coursesCubit,
      act: (cubit) => cubit.emitDeleteCourse(courseDummy),
      expect: () => [
        CourseDeleted(courseDummy.title),
        CoursesLoading(),
        CoursesLoaded([courseDummy]),
      ],
    );

    blocTest(
      'Failed',
      setUp: () {
        fetchCoursesUseCaseMock.executeResult = [courseDummy];
      },
      build: () => coursesCubit,
      act: (cubit) => cubit.emitDeleteCourse(courseDummy),
      expect: () => [
        CoursesError(ErrorCode.genericError.message),
      ],
    );
  });
}
