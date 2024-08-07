import 'package:bloc/bloc.dart';
import '../../../domain/usecase/usecase.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/models.dart';
import '../../../resources/resources.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final FetchCoursesUseCase _fetchCourseUseCase;
  final DeleteCoursesUseCase _deleteCoursesUseCase;
  final IsAuthenticatedUseCase isAuthenticatedUseCase;

  CoursesCubit(
    this._fetchCourseUseCase,
    this._deleteCoursesUseCase,
    this.isAuthenticatedUseCase,
  ) : super(CoursesInitial());

  void emitAuthenticateUser(bool availableConnection) async {
    final userAuthenticated = await isAuthenticatedUseCase.execute();
    if (userAuthenticated) {
      emitFetchCourses(availableConnection);
    } else {
      emit(CoursesLoginModal());
    }
  }

  void emitFetchCourses(bool availableConnection) async {
    try {
      emit(CoursesLoading());
      final courses = await _fetchCourseUseCase.execute(
        availableConnection: availableConnection,
      );
      emit(CoursesLoaded(courses));
    } catch (error) {
      emit(CoursesError((error as ErrorServiceModel).message));
    }
  }

  void emitSelectedCourse(CourseModel course) {
    emit(CourseSelected(course, false));
  }

  void emitNewCourse() {
    final course = CourseModel.newCourse(
      title: '',
      category: CategoryCourseModel.web,
    );
    emit(CourseSelected(course, true));
  }

  void emitDeleteCourse(CourseModel course) async {
    try {
      final courseTitle = course.title;
      await _deleteCoursesUseCase.execute(course.identifier, true);
      emit(CourseDeleted(courseTitle));
      await Future.delayed(const Duration(milliseconds: 500));
      emitFetchCourses(true);
    } catch (error) {
      emit(CoursesError((error as ErrorServiceModel).message));
    }
  }
}
