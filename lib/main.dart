import 'package:flutter/material.dart';

import 'routes/app_route.dart';

void main() {
  runApp(BlocCourseApp(appRoute: AppRoutes()));
}

class BlocCourseApp extends StatelessWidget {
  const BlocCourseApp({super.key, required this.appRoute});

  final AppRoutes appRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
    );
  }
}
