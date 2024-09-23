import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../logic/logic.dart';
import '../../common_widgets/common_widgets.dart';

class CameraScreen extends StatefulWidget {
  static var name = 'camera_screen';

  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<CameraCubit, CameraState>(
            listener: (context, state) {
              if (state is CameraCaptureSuccess) {
                BlocProvider.of<UserProfileCubit>(context)
                    .emitEditAvatar(state.avatarImage);
                context.pop();
              }
            },
            builder: (context, state) {
              if (state is CameraInitial) {
                return const AppLoading();
              }
              if (state is CameraReady) {
                return Stack(
                  children: [
                    CameraPreview(
                      BlocProvider.of<CameraCubit>(context).cameraController!,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24)),
                            color: Colors.black),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () async {
                                  BlocProvider.of<CameraCubit>(context)
                                      .emitTakePicture();
                                },
                                iconSize: 50,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
