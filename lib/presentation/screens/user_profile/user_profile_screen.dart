import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/logic.dart';
import '../../common_widgets/common_widgets.dart';
import 'widgets/avatat.dart';
import 'widgets/user_form.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() {
    return _UserProfileScreenState();
  }
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final isAvailableConnection =
          BlocProvider.of<SettingsCubit>(context).state.isAvailableConnection;
      BlocProvider.of<UserProfileCubit>(context)
          .emitFecthUser(isAvailableConnection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: _ui(),
    );
  }

  _ui() {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileLoaded && state.wasUpdated) {
          _showSnackbar();
        }
      },
      builder: (context, state) {
        if (state is UserProfileLoading) {
          return const AppLoading();
        }
        final width = MediaQuery.of(context).size.width;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: width < 600 ? _vertical() : _horizontal(),
        );
      },
    );
  }

  _horizontal() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Avatar(),
        SizedBox(width: 20),
        Expanded(child: UserForm()),
      ],
    );
  }

  _vertical() {
    return const Center(
      child: Column(
        children: [
          Avatar(),
          Divider(
            height: 20,
            color: Color.fromARGB(255, 211, 206, 206),
            thickness: 5,
          ),
          UserForm(),
        ],
      ),
    );
  }

  _showSnackbar() {
    const snackBar = SnackBar(
      content: Text('Success'),
      backgroundColor: Colors.lightGreen,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
