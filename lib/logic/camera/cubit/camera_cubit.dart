import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';

import '../../../resources/resources.dart';
import 'camera_provider.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;
  CameraProvider cameraProvider;

  CameraCubit({CameraProvider? cameraProvider})
      : cameraProvider = cameraProvider ?? DefaultCameraProvider(),
        super(CameraInitial()) {
    emitinitializeCamera();
  }

  void emitinitializeCamera() async {
    try {
      _cameraController = await cameraProvider.getCameraController();
      await _cameraController!.initialize();
      emit(CameraReady());
    } catch (exception) {
      log(exception.toString());
      emit(CameraFailure());
    }
  }

  void emitTakePicture() async {
    try {
      if (_cameraController != null &&
          !_cameraController!.value.isTakingPicture) {
        await _cameraController!.setFlashMode(FlashMode.off);
        final picture = await _cameraController!.takePicture();
        final photo = await picture.readAsBytes();
        final avatarImage = await _preparePicture(photo);
        emit(CameraCaptureSuccess(avatarImage));
      }
    } on CameraException catch (_) {
      emit(CameraCaptureFailure());
    }
  }

  Future<String> _preparePicture(Uint8List picture) async {
    final pictureCompressed = await FlutterImageCompress.compressWithList(
      picture,
      minHeight: 960,
      minWidth: 540,
      quality: 10,
      rotate: 0,
    );
    return base64Encode(pictureCompressed);
  }

  @override
  Future<void> close() {
    _cameraController?.dispose();
    return super.close();
  }
}
