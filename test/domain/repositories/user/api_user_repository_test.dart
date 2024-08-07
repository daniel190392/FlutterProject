import 'dart:convert';
import 'package:continental_app/resources/resources.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/respositories/respositories.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late MockClient mockClient;
  late APIUserProfileRepository sut;
  const getUserUrl = 'user/653c20ac96680964f7286ccb';
  const userId = '653c20ac96680964f7286ccb';

  setUp(() {
    mockClient = MockClient();
    sut = APIUserProfileRepository(mockClient);
  });

  group('Get User', () {
    const dummyUser = UserModel(
      userId: '653c20ac96680964f7286ccb',
      name: 'Daniel',
      latitude: -11.8125462,
      longitude: -77.1212482,
      address: 'Av. Carretera Panamericana Norte Km 39 - Ancón',
    );
    const jsonUserSuccess = """ {
      "id": "653c20ac96680964f7286ccb",
      "dob": "1985-02-04T23:00:00.000Z",
      "name": "Daniel",
      "email": "cristiano.ronaldo@realmadrid.com",
      "address": "Av. Carretera Panamericana Norte Km 39 - Ancón",
      "latitude": -11.8125462,
      "longitude": -77.1212482
    }
    """;

    test('Should return the user', () async {
      // GIVEN
      final url = sut.getUri(getUserUrl);
      when(mockClient.get(url))
          .thenAnswer((_) async => http.Response(jsonUserSuccess, 200));

      // WHEN
      final result = await sut.getUser(userId);

      // THEN
      expect(result.name, dummyUser.name);
      expect(result.latitude, dummyUser.latitude);
      expect(result.longitude, dummyUser.longitude);
      expect(result.address, dummyUser.address);
    });

    test('Should throw an error when status code is not 200', () async {
      // GIVEN
      final url = sut.getUri(getUserUrl);
      when(mockClient.get(url)).thenAnswer((_) async => http.Response('', 404));

      // WHEN
      try {
        await sut.getUser(userId);
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

  group('Update User', () {
    const headers = {'Content-Type': 'application/json'};
    const dummyUser = UserModel(
      userId: '',
      name: 'CR7',
      latitude: -11.8125462,
      longitude: -77.1212482,
      address: 'Av. Carretera Panamericana',
    );

    test('Should update the user', () async {
      // GIVEN
      final url = sut.getUri(getUserUrl);
      final body = json.encode(dummyUser.toMap());
      when(mockClient.patch(url, headers: headers, body: body))
          .thenAnswer((_) async => http.Response('', 200));

      // WHEN
      final result = await sut.updateUser(userId, dummyUser.toMap());

      // THEN
      expect(result, isTrue);
    });

    test('Should throw an error when status code is not 200', () async {
      // GIVEN
      final url = sut.getUri(getUserUrl);
      final body = json.encode(dummyUser.toMap());
      when(mockClient.patch(url, headers: headers, body: body))
          .thenAnswer((_) async => http.Response('', 404));

      // WHEN
      final result = await sut.updateUser(userId, dummyUser.toMap());

      // THEN
      expect(!result, isTrue);
    });
  });
}
