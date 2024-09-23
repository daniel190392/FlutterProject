import 'package:continental_app/logic/logic.dart';
import 'package:continental_app/presentation/common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() {
    return _LoginModalState();
  }
}

class _LoginModalState extends State<LoginModal> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.text = 'daniel@continental.com';
    _passwordController.text = 'xxxxxx';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubitBuilder.builder(),
      child: _ui(),
    );
  }

  _ui() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (settingsContext, settingsState) {
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoaded) {
                BlocProvider.of<CoursesCubit>(context).emitFetchCourses(
                  settingsState.isAvailableConnection,
                );
                context.pop();
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    readOnly: true,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    readOnly: true,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: state is! LoginLoading
                        ? () {
                            BlocProvider.of<LoginCubit>(context).emitLogin();
                          }
                        : null,
                    child: const Text('Login'),
                  ),
                  if (state is LoginLoading) const AppLoading()
                ],
              );
            },
          );
        },
      ),
    );
  }
}
