import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/logic.dart';
import 'courses_item.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocConsumer<CoursesCubit, CoursesState>(
        listener: (context, state) {
          if (state is CourseDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('The course deleted was ${state.title}'),
                duration: const Duration(milliseconds: 500),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CoursesLoaded) {
            final courses = state.courses;
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (settingsContext, settingsState) {
                return ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (ctx, index) => settingsState
                          .isAvailableConnection
                      ? Dismissible(
                          background: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onDismissed: (direction) {
                            BlocProvider.of<CoursesCubit>(context)
                                .emitDeleteCourse(courses[index]);
                          },
                          key: ValueKey(courses[index]),
                          child: CoursesItem(courses[index]),
                        )
                      : Container(
                          key: ValueKey(courses[index]),
                          child: CoursesItem(courses[index]),
                        ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
