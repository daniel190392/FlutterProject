import 'package:camera/camera.dart';

abstract class CameraProvider {
  Future<CameraController> getCameraController();
}

class DefaultCameraProvider extends CameraProvider {
  @override
  Future<CameraController> getCameraController() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    return CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
  }
}
