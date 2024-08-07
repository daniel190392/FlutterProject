import 'package:camera/camera.dart';
import 'package:continental_app/logic/logic.dart';
import 'package:mockito/mockito.dart';

class CameraControllerMock extends Mock implements CameraController {}

class CameraProviderMock extends CameraProvider {
  @override
  Future<CameraController> getCameraController() async {
    return CameraControllerMock();
  }
}
