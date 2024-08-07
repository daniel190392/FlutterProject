part of 'course_detail_cubit.dart';

@immutable
sealed class CourseDetailState extends Equatable {
  final CourseModel? course;
  final List<CategoryCourseModel> categories = CategoryCourseModel.values;
  final bool isNewCourse;

  CourseDetailState({
    this.course,
    bool? isNewCourse,
  }) : isNewCourse = isNewCourse ?? false;

  @override
  List<Object?> get props => [
        course,
        categories,
        isNewCourse,
      ];
}

final class CourseDetailInitial extends CourseDetailState {}

final class CourseDetailLoaded extends CourseDetailState {
  CourseDetailLoaded(
    CourseModel course,
    bool isNewCourse,
  ) : super(
          course: course,
          isNewCourse: isNewCourse,
        );
}

final class CourseDetailLoading extends CourseDetailState {
  CourseDetailLoading(
    CourseModel? course,
    bool isNewCourse,
  ) : super(
          course: course,
          isNewCourse: isNewCourse,
        );
}

final class CourseDetailEdited extends CourseDetailState {
  CourseDetailEdited(
    CourseModel course,
    bool isNewCourse,
  ) : super(
          course: course,
          isNewCourse: isNewCourse,
        );
}

final class CourseDetailCompleted extends CourseDetailState {}

final class CourseDetailError extends CourseDetailState {
  final String message;

  CourseDetailError(this.message);
}
