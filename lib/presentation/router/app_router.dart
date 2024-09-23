import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: CoursesScreen.name,
      builder: (context, state) => const CoursesScreen(),
    ),
    GoRoute(
      path: '/detail',
      name: CourseDetailScreen.name,
      builder: (context, state) => const CourseDetailScreen(),
    ),
    GoRoute(
      path: '/user',
      name: UserProfileScreen.name,
      builder: (context, state) => const UserProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: SettingsScreen.name,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/camera',
      name: CameraScreen.name,
      builder: (context, state) => const CameraScreen(),
    ),
    GoRoute(
      path: '/map',
      name: MapScreen.name,
      builder: (context, state) {
        final location = state.extra as Tuple3<double?, double?, String?>;
        return MapScreen(
          latitude: location.item1,
          longitude: location.item2,
          address: location.item3,
        );
      },
    ),
  ],
);
