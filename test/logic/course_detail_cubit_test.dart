import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/logic/logic.dart';
import 'package:continental_app/resources/resources.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../mocks/mocks.dart';

void main() {
  late AddCoursesUseCaseMock addCoursesUseCaseMock;
  late UpdateCoursesUseCaseMock updateCoursesUseCaseMock;
  late CourseDetailCubit courseDetailCubit;
  const expectedCourse = CourseModel(
    identifier: 'identifier',
    title: 'title',
    category: CategoryCourseModel.web,
  );
  const titleEdited = 'Edited';
  const categoryEdited = CategoryCourseModel.cloud;

  setUp(() {
    addCoursesUseCaseMock = AddCoursesUseCaseMock();
    updateCoursesUseCaseMock = UpdateCoursesUseCaseMock();
    courseDetailCubit = CourseDetailCubit(
      addCoursesUseCaseMock,
      updateCoursesUseCaseMock,
    );
  });

  test('The initial state for the CounterCubit', () {
    expect(courseDetailCubit.state, CourseDetailInitial());
  });

  group('CourseDetailCubit when create course', () {
    blocTest(
      'The CounterCubit receive a course()',
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitFetchCourse(expectedCourse, true),
      expect: () => [
        CourseDetailLoaded(expectedCourse, true),
      ],
    );

    blocTest(
      'The CounterCubit with title edited',
      setUp: () {
        courseDetailCubit.emitFetchCourse(expectedCourse, true);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitEditCourse(title: titleEdited),
      expect: () => [
        CourseDetailEdited(expectedCourse.copyWith(title: titleEdited), true),
      ],
    );

    blocTest(
      'The CounterCubit with category edited',
      setUp: () {
        courseDetailCubit.emitFetchCourse(expectedCourse, true);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitEditCourse(category: categoryEdited),
      expect: () => [
        CourseDetailEdited(
            expectedCourse.copyWith(category: categoryEdited), true),
      ],
    );

    blocTest(
      'The CounterCubit was saved with success result',
      setUp: () {
        addCoursesUseCaseMock.executeResult = true;
        courseDetailCubit.emitFetchCourse(expectedCourse, true);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitSaveCourse(),
      expect: () => [
        CourseDetailLoading(expectedCourse, true),
        CourseDetailCompleted(),
      ],
      verify: (_) {
        expect(updateCoursesUseCaseMock.executeWasCalled, false);
        expect(addCoursesUseCaseMock.executeWasCalled, true);
      },
    );

    blocTest(
      'The CounterCubit was saved with failed result',
      setUp: () {
        courseDetailCubit.emitFetchCourse(expectedCourse, true);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitSaveCourse(),
      expect: () => [
        CourseDetailLoading(expectedCourse, true),
        CourseDetailError(ErrorCode.genericError.message),
      ],
      verify: (_) {
        expect(updateCoursesUseCaseMock.executeWasCalled, false);
        expect(addCoursesUseCaseMock.executeWasCalled, true);
      },
    );
  });

  group('CourseDetailCubit when edit course', () {
    blocTest(
      'The CounterCubit receive a course()',
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitFetchCourse(expectedCourse, false),
      expect: () => [
        CourseDetailLoaded(expectedCourse, false),
      ],
    );

    blocTest(
      'The CounterCubit with title edited',
      setUp: () {
        courseDetailCubit.emitFetchCourse(expectedCourse, false);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitEditCourse(title: titleEdited),
      expect: () => [
        CourseDetailEdited(expectedCourse.copyWith(title: titleEdited), false),
      ],
    );

    blocTest(
      'The CounterCubit with category edited',
      setUp: () {
        courseDetailCubit.emitFetchCourse(expectedCourse, false);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitEditCourse(category: categoryEdited),
      expect: () => [
        CourseDetailEdited(
            expectedCourse.copyWith(category: categoryEdited), false),
      ],
    );

    blocTest(
      'The CounterCubit was saved with success result',
      setUp: () {
        updateCoursesUseCaseMock.executeResult = true;
        courseDetailCubit.emitFetchCourse(expectedCourse, false);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitSaveCourse(),
      expect: () => [
        CourseDetailLoading(expectedCourse, false),
        CourseDetailCompleted(),
      ],
      verify: (_) {
        expect(updateCoursesUseCaseMock.executeWasCalled, true);
        expect(addCoursesUseCaseMock.executeWasCalled, false);
      },
    );

    blocTest(
      'The CounterCubit was saved with failed result',
      setUp: () {
        courseDetailCubit.emitFetchCourse(expectedCourse, false);
      },
      build: () => courseDetailCubit,
      act: (cubit) => cubit.emitSaveCourse(),
      expect: () => [
        CourseDetailLoading(expectedCourse, false),
        CourseDetailError(ErrorCode.genericError.message),
      ],
      verify: (_) {
        expect(updateCoursesUseCaseMock.executeWasCalled, true);
        expect(addCoursesUseCaseMock.executeWasCalled, false);
      },
    );
  });

  blocTest(
    'The CounterCubit close screen',
    build: () => courseDetailCubit,
    act: (cubit) => cubit.emitClose(),
    expect: () => [
      CourseDetailCompleted(),
    ],
  );

  blocTest(
    'The CounterCubit failed when try to save without course',
    build: () => courseDetailCubit,
    act: (cubit) => cubit.emitSaveCourse(),
    expect: () => [
      CourseDetailLoading(null, false),
      CourseDetailError('expected course'),
    ],
  );
}
