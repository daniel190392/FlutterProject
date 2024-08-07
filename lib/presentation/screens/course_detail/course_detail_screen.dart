import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/models.dart';
import '../../../logic/logic.dart';
import '../../common_widgets/common_widgets.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() {
    return _CourseDetailScreenState();
  }
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contex) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (settingsContext, settingsState) {
        return BlocListener<CourseDetailCubit, CourseDetailState>(
          listener: (context, state) {
            if (state is CourseDetailCompleted) {
              BlocProvider.of<CoursesCubit>(contex).emitFetchCourses(
                settingsState.isAvailableConnection,
              );
              Navigator.pop(contex);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Detalle del curso '),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  BlocProvider.of<CourseDetailCubit>(contex).emitClose();
                },
              ),
            ),
            body: _ui(),
          ),
        );
      },
    );
  }

  _ui() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (settingsContext, settingsState) {
          return BlocBuilder<CourseDetailCubit, CourseDetailState>(
            builder: (context, state) {
              if (state is CourseDetailLoading) {
                return const AppLoading();
              }
              if (state is CourseDetailError) {
                return Container();
              }
              return Column(
                children: <Widget>[
                  TextField(
                    readOnly: !settingsState.isAvailableConnection,
                    style: Theme.of(context).textTheme.bodySmall,
                    controller: _nameController
                      ..text = state.course?.title ?? '',
                    maxLength: 100,
                    decoration: const InputDecoration(
                      label: Text('Nombre del curso:'),
                    ),
                    onChanged: (text) {
                      BlocProvider.of<CourseDetailCubit>(context)
                          .emitEditCourse(title: text);
                    },
                  ),
                  Row(
                    children: [
                      const Text('Tipo de categoria:'),
                      const SizedBox(width: 10),
                      DropdownButton(
                        style: Theme.of(context).textTheme.bodySmall,
                        items: state.categories
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ))
                            .toList(),
                        value: state.course?.category,
                        onChanged: settingsState.isAvailableConnection
                            ? (value) {
                                if (value == null ||
                                    value is! CategoryCourseModel) {
                                  return;
                                }
                                setState(() {
                                  BlocProvider.of<CourseDetailCubit>(context)
                                      .emitEditCourse(category: value);
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitData(context, state),
                    child: Text(
                      state.isNewCourse ? 'Save Course' : 'Update Course',
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

void Function()? _submitData(BuildContext contex, CourseDetailState state) {
  if (state is CourseDetailEdited) {
    return () async {
      BlocProvider.of<CourseDetailCubit>(contex).emitSaveCourse();
    };
  } else {
    return null;
  }
}
