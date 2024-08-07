import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late AuthenticationRepositoryMock authenticationRepositoryMock;
  late DefaultSetAuthenticationUseCase sut;

  setUp(() {
    authenticationRepositoryMock = AuthenticationRepositoryMock();
    sut = DefaultSetAuthenticationUseCase(authenticationRepositoryMock);
  });

  group('Get userId', () {
    test('Execute with success result', () async {
      //GIVEN
      authenticationRepositoryMock.setValueWithSuccessResult = true;

      // WHEN
      await sut.execute(true);

      // THEN
      expect(authenticationRepositoryMock.setValueWithWasCalled, true);
    });

    test('Execute with error', () async {
      try {
        // WHEN
        await sut.execute(true);
        fail('expected error');
      } catch (error) {
        // THEN
        expect(error is Error, true);
        expect(authenticationRepositoryMock.setValueWithWasCalled, true);
      }
    });
  });
}
