import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

import '../../../../logic/logic.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() {
    return _UserFormState();
  }
}

class _UserFormState extends State<UserForm> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (settingContext, settingState) {
        return BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoaded) {
              return Column(
                children: [
                  TextField(
                    readOnly: !settingState.isAvailableConnection,
                    style: Theme.of(context).textTheme.bodySmall,
                    controller: _nameController..text = state.user.name,
                    decoration: InputDecoration(
                      label: Text(
                        'Nombre del usuario:',
                        style: TextStyle(
                          color: isDarkMode
                              ? Theme.of(context).colorScheme.inversePrimary
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _onChangedText(value);
                    },
                  ),
                  TextField(
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodySmall,
                    controller: _addressController..text = state.user.address,
                    decoration: InputDecoration(
                      labelText: "Dirección",
                      labelStyle: TextStyle(
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.inversePrimary
                            : Theme.of(context).colorScheme.primary,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          if (settingState.isAvailableConnection) {
                            _goToMap(
                              state.user.latitude,
                              state.user.longitude,
                              state.user.address,
                            );
                          }
                        },
                        child: Tab(
                          icon: Image.asset(
                            'assets/images/map.png',
                            color: settingState.isAvailableConnection
                                ? null
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  settingState.isAvailableConnection
                      ? ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<UserProfileCubit>(context)
                                .emitUpdateUser(state.user);
                          },
                          child: const Text('Update user'),
                        )
                      : Container(),
                ],
              );
            }
            return Container();
          },
        );
      },
    );
  }

  _onChangedText(String text) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    } else {
      _debounce = Timer(
        const Duration(milliseconds: 1000),
        () {
          BlocProvider.of<UserProfileCubit>(context).emitEditUserName(text);
        },
      );
    }
  }

  _goToMap(double? latitude, double? longitude, String? address) async {
    await Navigator.pushNamed(
      context,
      '/map',
      arguments: Tuple3(
        latitude,
        longitude,
        address,
      ),
    );
  }
}
