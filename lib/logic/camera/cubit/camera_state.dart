part of 'camera_cubit.dart';

@immutable
sealed class CameraState extends Equatable {}

final class CameraInitial extends CameraState {
  @override
  List<Object?> get props => [];
}

final class CameraFailure extends CameraState {
  @override
  List<Object?> get props => [];
}

final class CameraReady extends CameraState {
  @override
  List<Object?> get props => [];
}

final class CameraCaptureSuccess extends CameraState {
  final String avatarImage;

  CameraCaptureSuccess(this.avatarImage);

  @override
  List<Object?> get props => [avatarImage];
}

final class CameraCaptureFailure extends CameraState {
  @override
  List<Object?> get props => [];
}
