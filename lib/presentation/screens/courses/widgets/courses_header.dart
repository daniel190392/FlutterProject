import 'package:flutter/material.dart';

class CoursesHeader extends StatelessWidget {
  const CoursesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8, bottom: 8, right: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDarkMode
              ? Theme.of(context).colorScheme.background
              : Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.book_outlined,
              size: 50,
              color: isDarkMode
                  ? Theme.of(context).colorScheme.inverseSurface
                  : Theme.of(context).colorScheme.background,
            ),
            const SizedBox(width: 10),
            Text(
              'Lista de cursos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
