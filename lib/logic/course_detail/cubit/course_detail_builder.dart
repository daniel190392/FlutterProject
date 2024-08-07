import 'package:continental_app/logic/logic.dart';
import 'package:http/http.dart';

import '../../../domain/respositories/course/course.dart';
import '../../../domain/usecase/usecase.dart';

class CourseDetailCubitBuilder {
  static CourseDetailCubit builder() {
    CourseRepository apiRepository = APICourseRepository(Client());
    CourseRepository dbRepository = DBCourseRepository();
    AddCoursesUseCase addCoursesUseCase = DefaultAddCoursesUseCase(
      apiRepository,
      dbRepository,
    );
    UpdateCoursesUseCase updateCoursesUseCase = DefaultUpdateCoursesUseCase(
      apiRepository,
      dbRepository,
    );
    return CourseDetailCubit(addCoursesUseCase, updateCoursesUseCase);
  }
}
