import 'package:continental_app/logic/logic.dart';
import 'package:http/http.dart';

import '../../../domain/respositories/respositories.dart';
import '../../../domain/usecase/usecase.dart';

class CoursesCubitBuilder {
  static CoursesCubit builder() {
    CourseRepository apiRepository = APICourseRepository(Client());
    CourseRepository dbRepository = DBCourseRepository();
    FetchCoursesUseCase fetchCourseUseCase = DefaultFetchCoursesUseCase(
      apiRepository,
      dbRepository,
    );
    DeleteCoursesUseCase deleteCourseUseCase = DefaultDeleteCoursesUseCase(
      apiRepository,
      dbRepository,
    );
    IsAuthenticatedUseCase isUserLoginUseCase = DefaultIsAuthenticatedUseCase(
      SharedPreferenceAuthenticationRepository(),
    );
    return CoursesCubit(
      fetchCourseUseCase,
      deleteCourseUseCase,
      isUserLoginUseCase,
    );
  }
}
