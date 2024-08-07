part of 'courses_cubit.dart';

@immutable
sealed class CoursesState extends Equatable {}

final class CoursesInitial extends CoursesState {
  @override
  List<Object?> get props => [];
}

final class CoursesLoginModal extends CoursesState {
  @override
  List<Object?> get props => [];
}

final class CoursesLoading extends CoursesState {
  @override
  List<Object?> get props => [];
}

final class CoursesLoaded extends CoursesState {
  CoursesLoaded(this.courses);

  final List<CourseModel> courses;

  @override
  List<Object?> get props => [courses];
}

final class CourseSelected extends CoursesState {
  CourseSelected(this.course, this.isNewCourse);

  final CourseModel course;
  final bool isNewCourse;

  @override
  List<Object?> get props => [course, isNewCourse];
}

final class CourseDeleted extends CoursesState {
  CourseDeleted(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

final class CoursesError extends CoursesState {
  CoursesError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
