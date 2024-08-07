import 'package:continental_app/domain/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('User Model', () {
    test('test init', () {
      const userModel = UserModel(
        userId: '0',
        name: 'Daniel',
        latitude: 12,
        longitude: 12,
        address: 'address',
      );
      expect(userModel.userId, '0');
      expect(userModel.name, 'Daniel');
      expect(userModel.latitude, 12);
      expect(userModel.longitude, 12);
      expect(userModel.address, 'address');
      expect(userModel.avatarImage, isNull);
    });

    test('test init with image', () {
      const userModel = UserModel(
        userId: '0',
        name: 'Daniel',
        latitude: 12,
        longitude: 12,
        address: 'address',
        avatarImage: 'ppp',
      );
      expect(userModel.userId, '0');
      expect(userModel.name, 'Daniel');
      expect(userModel.latitude, 12);
      expect(userModel.longitude, 12);
      expect(userModel.address, 'address');
      expect(userModel.avatarImage, 'ppp');
    });

    test('test from json', () {
      final json = {
        'id': '0',
        'name': 'Daniel',
        'address': 'address',
        'latitude': 12.0,
        'longitude': 12.0,
        'photo': 'avatar',
      };
      final userModel = UserModel.fromMap(json);
      expect(userModel.userId, '0');
      expect(userModel.name, 'Daniel');
      expect(userModel.address, 'address');
      expect(userModel.latitude, 12);
      expect(userModel.longitude, 12);
      expect(userModel.avatarImage, 'avatar');
    });

    test('test from json without photo', () {
      final json = {
        'id': '0',
        'name': 'Daniel',
        'address': 'address',
        'latitude': 12.0,
        'longitude': 12.0,
      };
      final userModel = UserModel.fromMap(json);
      expect(userModel.userId, '0');
      expect(userModel.name, 'Daniel');
      expect(userModel.address, 'address');
      expect(userModel.latitude, 12);
      expect(userModel.longitude, 12);
      expect(userModel.avatarImage, isNull);
    });

    test('test from string', () {
      const file = '''
      {
        "id": "0",
        "name": "Daniel",
        "address": "address",
        "latitude": 12.0,
        "longitude": 12.0
      }
      ''';
      final userModel = UserModel.fromJson(file);
      expect(userModel.userId, '0');
      expect(userModel.name, 'Daniel');
      expect(userModel.address, 'address');
      expect(userModel.latitude, 12);
      expect(userModel.longitude, 12);
      expect(userModel.avatarImage, isNull);
    });

    test('test invalid json', () {
      final json = {
        'id': '0',
        'name': 'Daniel',
        'latitude': 12.0,
        'longitude': 12.0,
        'photo': 'avatar',
      };
      try {
        UserModel.fromMap(json);
        fail('expected invalid json');
      } catch (exception) {
        expect(exception is FormatException, isTrue);
      }
    });

    test('test model to json', () {
      const userModel = UserModel(
        userId: '0',
        name: 'Daniel',
        latitude: 12,
        longitude: 12,
        address: 'address',
      );
      try {
        expect(userModel.toJson().isNotEmpty, true);
      } catch (exception) {
        fail('expected valid json');
      }
    });
  });
}
