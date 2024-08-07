import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late AuthenticationRepositoryMock authenticationRepositoryMock;
  late DefaultGetUserIdUseCase sut;

  setUp(() {
    authenticationRepositoryMock = AuthenticationRepositoryMock();
    sut = DefaultGetUserIdUseCase(authenticationRepositoryMock);
  });

  group('Get userId', () {
    test('Execute with success result', () async {
      //GIVEN
      const expected = '0';
      authenticationRepositoryMock.getStringWithResult = expected;

      // WHEN
      final result = await sut.execute();

      // THEN
      expect(result, expected);
      expect(authenticationRepositoryMock.getStringWithWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute();
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(authenticationRepositoryMock.getStringWithWasCalled, true);
      }
    });
  });
}
