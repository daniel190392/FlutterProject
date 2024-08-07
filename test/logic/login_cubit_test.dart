import 'package:continental_app/logic/logic.dart';
import 'package:continental_app/logic/login/cubit/login_cubit.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../mocks/mocks.dart';

void main() {
  late LoginCubit loginCubit;
  late SetAuthenticationUseCaseMock setAuthenticationUseCaseMock;
  late SetUserIdUseCaseMock setUserIdUseCaseMock;

  setUp(() {
    setAuthenticationUseCaseMock = SetAuthenticationUseCaseMock();
    setUserIdUseCaseMock = SetUserIdUseCaseMock();
    loginCubit = LoginCubit(setAuthenticationUseCaseMock, setUserIdUseCaseMock);
  });

  group('Login Cubit', () {
    blocTest(
      'The CameraCubit login',
      setUp: () {
        setAuthenticationUseCaseMock.executeResult = true;
        setUserIdUseCaseMock.executeResult = true;
      },
      build: () => loginCubit,
      act: (cubit) => cubit.emitLogin(),
      expect: () => [
        LoginLoading(),
        LoginLoaded(),
      ],
      verify: (_) {
        expect(setUserIdUseCaseMock.executeWasCalled, true);
        expect(setAuthenticationUseCaseMock.executeWasCalled, true);
      },
    );

    blocTest(
      'The CameraCubit login with errors',
      build: () => loginCubit,
      act: (cubit) => cubit.emitLogin(),
      expect: () => [
        LoginLoading(),
        LoginError(),
      ],
      verify: (_) {
        expect(setUserIdUseCaseMock.executeWasCalled, true);
      },
    );
  });
}
