import 'package:continental_app/domain/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('Category course Model', () {
    test('test init', () {
      expect(
          CategoryCourseModel.mobile.toString(), 'CategoryCourseModel.mobile');
      expect(CategoryCourseModel.web.toString(), 'CategoryCourseModel.web');
      expect(CategoryCourseModel.cloud.toString(), 'CategoryCourseModel.cloud');
    });

    test('test init category by name', () {
      expect(CategoryCourseModel.byName('mobile'), CategoryCourseModel.mobile);
      expect(CategoryCourseModel.byName('web'), CategoryCourseModel.web);
      expect(CategoryCourseModel.byName('cloud'), CategoryCourseModel.cloud);
    });

    test('test init category with wrong name', () {
      try {
        CategoryCourseModel.byName('other');
        fail('expected invalid json');
      } catch (exception) {
        expect(exception is ArgumentError, isTrue);
      }
    });
  });
}
