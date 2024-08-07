import 'package:continental_app/logic/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/models.dart';
import '../../../../resources/resources.dart';

class CoursesItem extends StatelessWidget {
  const CoursesItem(this.course, {super.key});
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(null).byCategory(course.category),
              ),
            ),
            Text(course.title),
          ],
        ),
      ),
      onTap: () async {
        BlocProvider.of<CoursesCubit>(context).emitSelectedCourse(course);
      },
    );
  }
}
