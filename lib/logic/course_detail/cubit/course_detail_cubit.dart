import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/category_course_model.dart';
import '../../../domain/models/course_model.dart';
import '../../../domain/usecase/course/course.dart';
import '../../../resources/resources.dart';

part 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final AddCoursesUseCase _addCoursesUseCase;
  final UpdateCoursesUseCase _updateCoursesUseCase;

  CourseDetailCubit(this._addCoursesUseCase, this._updateCoursesUseCase)
      : super(CourseDetailInitial());

  void emitFetchCourse(CourseModel course, bool isNewCourse) {
    emit(CourseDetailLoaded(course, isNewCourse));
  }

  void emitEditCourse({String? title, CategoryCourseModel? category}) {
    if ((title != null || category != null) && state.course != null) {
      final newCourse = state.course!.copyWith(
        title: title ?? state.course!.title,
        category: category ?? state.course!.category,
      );
      emit(CourseDetailEdited(newCourse, state.isNewCourse));
    }
  }

  void emitSaveCourse() async {
    try {
      emit(CourseDetailLoading(state.course, state.isNewCourse));
      if (state.course != null) {
        state.isNewCourse
            ? await _addCoursesUseCase.execute(state.course!, true)
            : await _updateCoursesUseCase.execute(state.course!, true);
        emit(CourseDetailCompleted());
      } else {
        emit(CourseDetailError('expected course'));
      }
    } catch (error) {
      emit(CourseDetailError(error.toString()));
    }
  }

  void emitClose() {
    emit(CourseDetailCompleted());
  }
}
