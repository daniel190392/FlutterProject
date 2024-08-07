import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../screens/screens.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
      case '/detail':
        return MaterialPageRoute(builder: (_) => const CourseDetailScreen());
      case '/user':
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/camera':
        return MaterialPageRoute(builder: (_) => const CameraScreen());
      case '/map':
        if (arguments is Tuple3<double?, double?, String?>) {
          return MaterialPageRoute(
              builder: (_) => MapScreen(
                    latitude: arguments.item1,
                    longitude: arguments.item2,
                    address: arguments.item3,
                  ));
        } else {
          return MaterialPageRoute(builder: (_) => const CoursesScreen());
        }
      default:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
    }
  }
}
