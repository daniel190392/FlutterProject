import 'package:continental_app/presentation/screens/login/login_modal.dart';
import 'package:continental_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

import 'widgets/courses_header.dart';
import 'widgets/courses_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/logic.dart';
import '../../common_widgets/common_widgets.dart';

class CoursesScreen extends StatefulWidget {
  static var name = 'courses_screen';

  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final isAvailableConnection =
          BlocProvider.of<SettingsCubit>(context).state.isAvailableConnection;
      BlocProvider.of<CoursesCubit>(context)
          .emitAuthenticateUser(isAvailableConnection);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continental'),
        actions: _barActions(context),
      ),
      body: _ui(),
    );
  }

  List<Widget>? _barActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          context.pushNamed(UserProfileScreen.name);
        },
        icon: const Icon(Icons.person),
      ),
      IconButton(
        onPressed: () {
          context.pushNamed(SettingsScreen.name);
        },
        icon: const Icon(Icons.settings),
      )
    ];
  }

  _ui() {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {
        if (state is CoursesLoginModal) {
          _showModal();
        }
        if (state is CourseSelected) {
          BlocProvider.of<CourseDetailCubit>(context).emitFetchCourse(
            state.course,
            state.isNewCourse,
          );
          context.pushNamed(CourseDetailScreen.name);
        }
      },
      builder: (context, state) {
        if (state is CoursesLoading) {
          return const AppLoading();
        }
        if (state is CoursesLoaded) {
          return Column(
            children: [
              const CoursesHeader(),
              const Expanded(
                child: CoursesList(),
              ),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  if (state.isAvailableConnection) {
                    return FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<CoursesCubit>(context).emitNewCourse();
                      },
                      child: const Icon(Icons.add),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  _showModal() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return const LoginModal();
        });
  }
}
