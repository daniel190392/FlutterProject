import 'package:continental_app/logic/logic.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../mocks/mocks.dart';

void main() {
  late CameraCubit cameraCubit;
  late CameraControllerMock cameraControllerMock;

  setUp(() {
    cameraControllerMock = CameraControllerMock();
    cameraCubit = CameraCubit(cameraProvider: CameraProviderMock());
    when(cameraControllerMock.initialize()).thenAnswer((_) => Future.value());
  });

  group('CameraCubit', () {
    blocTest(
      'The CameraCubit init',
      build: () => cameraCubit,
      act: (cubit) => cubit.emitinitializeCamera(),
      expect: () => [],
    );
  });
}
