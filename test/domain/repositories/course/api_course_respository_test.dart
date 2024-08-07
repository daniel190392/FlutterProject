import 'package:continental_app/resources/resources.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/respositories/respositories.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late MockClient mockClient;
  late APICourseRepository sut;
  const courseUrl = 'course';

  setUp(() {
    mockClient = MockClient();
    sut = APICourseRepository(mockClient);
  });

  const headers = {'Content-Type': 'application/json'};
  final dummyCourse = CourseModel.newCourse(
    title: 'title',
    category: CategoryCourseModel.mobile,
  );

  group('Get Courses', () {
    const jsonCoursesSuccess = """
    [
      {
        "identifier": "0",
        "name": "IOS",
        "category": "mobile"
      },
      {
        "identifier": "1",
        "name": "Android",
        "category": "mobile"
      }
    ]
    """;

    test('Should return the courses', () async {
      // GIVEN
      final url = sut.getUri(courseUrl);
      when(mockClient.get(url))
          .thenAnswer((_) async => http.Response(jsonCoursesSuccess, 200));

      // WHEN
      final result = await sut.getCourses(null) as List<CourseModel>;

      // THEN
      expect(result.length, 2);
      expect(result[0].identifier, "0");
      expect(result[0].title, "IOS");
      expect(result[0].category, CategoryCourseModel.mobile);
      expect(result[1].identifier, "1");
      expect(result[1].title, "Android");
      expect(result[1].category, CategoryCourseModel.mobile);
    });

    test('Should throw an error when status code is not 200', () async {
      // GIVEN
      final url = sut.getUri(courseUrl);
      when(mockClient.get(url)).thenAnswer((_) async => http.Response('', 404));
      // WHEN
      try {
        await sut.getCourses(null);
        fail('Expected error');
      } catch (error) {
        // THEN
        expect(error is ErrorServiceModel, true);
        final message = (error as ErrorServiceModel).message;
        expect(message, ErrorCode.genericError.message);
        verify(mockClient.get(url));
      }
    });
  });

  group('Add Course', () {
    test('Should return success when add the course', () async {
      // GIVEN
      final url = sut.getUri(courseUrl);
      when(mockClient.post(url, headers: headers, body: dummyCourse.toJson()))
          .thenAnswer((_) async => http.Response('', 200));

      // WHEN
      final result = await sut.addCourse(dummyCourse.toMap());

      // THEN
      expect(result, true);
    });

    test('Should throw an error when status code is not 200', () async {
      // GIVEN
      final url = sut.getUri(courseUrl);
      when(mockClient.post(url, headers: headers, body: dummyCourse.toJson()))
          .thenAnswer((_) async => http.Response('', 404));

      // WHEN
      final result = await sut.addCourse(dummyCourse.toMap());

      // THEN
      expect(!result, isTrue);
    });
  });

  group('Update Course', () {
    final identifier = dummyCourse.identifier;
    final updateCourseUrl = '$courseUrl/$identifier';
    test('Should return success when update the course', () async {
      // GIVEN
      final url = sut.getUri(updateCourseUrl);
      when(mockClient.patch(url, headers: headers, body: dummyCourse.toJson()))
          .thenAnswer((_) async => http.Response('', 200));

      // WHEN
      final result = await sut.updateCourse(
        dummyCourse.identifier,
        dummyCourse.toMap(),
      );

      // THEN
      expect(result, true);
    });

    test('Should throw an error when status code is not 200', () async {
      // GIVEN
      final url = sut.getUri(updateCourseUrl);
      when(mockClient.patch(url, headers: headers, body: dummyCourse.toJson()))
          .thenAnswer((_) async => http.Response('', 404));

      // WHEN
      final result = await sut.updateCourse(
        dummyCourse.identifier,
        dummyCourse.toMap(),
      );

      // THEN
      expect(!result, isTrue);
    });
  });

  group('Delete Course', () {
    final identifier = dummyCourse.identifier;
    final deleteCourseUrl = '$courseUrl/$identifier';
    test('Should return success when update the course', () async {
      // GIVEN
      final url = sut.getUri(deleteCourseUrl);
      when(mockClient.delete(url))
          .thenAnswer((_) async => http.Response('', 200));

      // WHEN
      final result = await sut.deleteCourse(identifier);

      // THEN
      expect(result, true);
    });

    test('Should throw an error when status code is not 200', () async {
      // GIVEN
      final url = sut.getUri(deleteCourseUrl);
      when(mockClient.delete(url))
          .thenAnswer((_) async => http.Response('', 404));

      // WHEN
      final result = await sut.deleteCourse(identifier);

      // THEN
      expect(!result, isTrue);
    });
  });
}
