import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/logic.dart';

class Avatar extends StatelessWidget {
  final Uint8List? picture;

  const Avatar({super.key, this.picture});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state.isAvailableConnection) {
              Navigator.pushNamed(context, '/camera');
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode
                        ? Theme.of(context).colorScheme.inverseSurface
                        : Theme.of(context).colorScheme.primary,
                    width: 5,
                  ),
                ),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(80),
                    child: BlocBuilder<UserProfileCubit, UserProfileState>(
                      builder: (context, state) {
                        if (state is UserProfileLoaded &&
                            state.user.avatarImage != null) {
                          return _imageAvatar(state.user.avatarImage!);
                        } else {
                          return _defaultAvatar();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                right: 5,
                child: () {
                  if (state.isAvailableConnection) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 191, 185, 185),
                        border: Border.all(
                          color: isDarkMode
                              ? Theme.of(context).colorScheme.inverseSurface
                              : Theme.of(context).colorScheme.background,
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Color.fromARGB(255, 50, 51, 52),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }(),
              ),
            ],
          ),
        );
      },
    );
  }

  _defaultAvatar() {
    return Image.asset(
      'assets/images/user.png',
      fit: BoxFit.cover,
    );
  }

  _imageAvatar(String avatarImage) {
    return Image.memory(
      base64Decode(avatarImage),
      fit: BoxFit.cover,
    );
  }
}
