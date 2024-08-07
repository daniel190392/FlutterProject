import 'package:continental_app/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                BlocProvider.of<CoursesCubit>(context).emitFetchCourses(
                  state.isAvailableConnection,
                );
                Navigator.pop(context);
              },
            ),
          ),
          body: _ui(context, state),
        );
      },
    );
  }

  _ui(BuildContext context, SettingsState state) {
    return SwitchListTile(
      title: const Text('Wifi enabled'),
      value: state.isAvailableConnection,
      onChanged: (bool value) {
        setState(() {
          BlocProvider.of<SettingsCubit>(context).emitChange(value);
        });
      },
    );
  }
}
