import 'package:continental_app/domain/usecase/usecase.dart';
import 'package:test/test.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late AuthenticationRepositoryMock authenticationRepositoryMock;
  late DefaultIsAuthenticatedUseCase sut;

  setUp(() {
    authenticationRepositoryMock = AuthenticationRepositoryMock();
    sut = DefaultIsAuthenticatedUseCase(authenticationRepositoryMock);
  });

  group('Get userId', () {
    test('Execute with success result', () async {
      //GIVEN
      const expected = true;
      authenticationRepositoryMock.getBoolWithResult = expected;

      // WHEN
      final result = await sut.execute();

      // THEN
      expect(result, expected);
      expect(authenticationRepositoryMock.getBoolWithWasCalled, true);
    });

    test('Execute with error', () async {
      // WHEN
      final result = await sut.execute();

      // THEN
      expect(result, false);
      expect(authenticationRepositoryMock.getBoolWithWasCalled, true);
    });
  });
}
