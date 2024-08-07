import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late UserRepositoryMock apiUserRepositoryMock;
  late UserRepositoryMock dbUserRepositoryMock;
  late GetUserUseCase sut;

  setUp(() {
    apiUserRepositoryMock = UserRepositoryMock();
    dbUserRepositoryMock = UserRepositoryMock();
    sut = DefaultGetUserUseCase(
      apiUserRepositoryMock,
      dbUserRepositoryMock,
    );
  });

  const userDummy = UserModel(
    userId: 'userId',
    name: 'name',
    latitude: 0,
    longitude: 0,
    address: 'address',
  );

  group('Get user usecase with API', () {
    test('Execute with success result', () async {
      // GIVEN
      apiUserRepositoryMock.getUserResult = userDummy;

      // WHEN
      final result = await sut.execute('userId', true);

      // THEN
      expect(userDummy, result);
      expect(apiUserRepositoryMock.getUserWasCalled, true);
      expect(dbUserRepositoryMock.getUserWasCalled, false);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute('userId', true);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiUserRepositoryMock.getUserWasCalled, true);
        expect(dbUserRepositoryMock.getUserWasCalled, false);
      }
    });
  });

  group('Get User usecase with local database', () {
    test('Execute with success result', () async {
      // GIVEN
      dbUserRepositoryMock.getUserResult = userDummy;

      // WHEN
      final result = await sut.execute('userId', false);

      // THEN
      expect(userDummy, result);
      expect(apiUserRepositoryMock.getUserWasCalled, false);
      expect(dbUserRepositoryMock.getUserWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute('userId', false);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiUserRepositoryMock.getUserWasCalled, false);
        expect(dbUserRepositoryMock.getUserWasCalled, true);
      }
    });
  });
}
