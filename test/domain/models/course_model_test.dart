import 'package:continental_app/domain/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Course Model', () {
    test('test init', () {
      const courseModel = CourseModel(
        identifier: '0',
        title: 'Course',
        category: CategoryCourseModel.mobile,
      );
      expect(courseModel.identifier, '0');
      expect(courseModel.title, 'Course');
      expect(courseModel.category, CategoryCourseModel.mobile);
    });

    test('test course with identifier auto generated', () {
      final courseModel = CourseModel.newCourse(
        title: 'Course',
        category: CategoryCourseModel.mobile,
      );
      expect(courseModel.identifier.isNotEmpty, true);
      expect(courseModel.title, 'Course');
      expect(courseModel.category, CategoryCourseModel.mobile);
    });

    test('test course to json', () {
      final courseModel = CourseModel.newCourse(
        title: 'Course',
        category: CategoryCourseModel.mobile,
      );
      expect(courseModel.toJson().isNotEmpty, true);
    });

    test('test json to course', () {
      const file = '''
      {
        "identifier": "0",
        "title": "Course",
        "category": "mobile"
      }
      ''';
      final courseModel = CourseModel.fromJson(file);
      expect(courseModel.identifier, '0');
      expect(courseModel.title, 'Course');
      expect(courseModel.category, CategoryCourseModel.mobile);
    });

    test('test invalid json to course', () {
      try {
        const file = '''
        {
          "identifier": "0",
          "title": "Course",
          "category": "hybrid"
        }
        ''';
        CourseModel.fromJson(file);
        fail('expected invalid json');
      } catch (exception) {
        expect(exception is FormatException, isTrue);
      }
    });
  });
}
