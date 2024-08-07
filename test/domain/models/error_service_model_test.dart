import 'package:continental_app/domain/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('User Model', () {
    test('test init', () {
      expect(ErrorServiceModel('Error').message, 'Error');
    });
  });
}
