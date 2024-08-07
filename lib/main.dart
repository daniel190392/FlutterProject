import 'logic/logic.dart';
import 'presentation/router/app_router.dart';
import 'resources/resources.dart';
import 'package:flutter/material.dart';

import 'presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoursesCubit>(
            create: (context) => CoursesCubitBuilder.builder()),
        BlocProvider<CourseDetailCubit>(
            create: (context) => CourseDetailCubitBuilder.builder()),
        BlocProvider<UserProfileCubit>(
            create: (context) => UserProfileCubitBuilder.builder()),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Continental',
        onGenerateRoute: appRouter.onGenerateRoute,
        initialRoute: '/',
        theme: ColorTheme.fetchColorScheme(),
        darkTheme: ColorTheme.fetchDarkColorScheme(),
      ),
    );
  }
}
