import 'package:continental_app/domain/models/models.dart';
import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late UserRepositoryMock apiUserRepositoryMock;
  late UpdateUserUseCase sut;

  setUp(() {
    apiUserRepositoryMock = UserRepositoryMock();
    sut = DefaultUpdateUserUseCase(apiUserRepositoryMock);
  });

  const userDummy = UserModel(
    userId: 'userId',
    name: 'name',
    latitude: 0,
    longitude: 0,
    address: 'address',
  );

  group('Update user usecase', () {
    test('Execute with success result', () async {
      // GIVEN
      apiUserRepositoryMock.updateUserResult = true;

      // WHEN
      final result = await sut.execute('userId', userDummy);

      // THEN
      expect(result, true);
      expect(apiUserRepositoryMock.updateUserWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute('userId', userDummy);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(apiUserRepositoryMock.updateUserWasCalled, true);
      }
    });
  });
}
