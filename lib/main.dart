import 'package:flutter/material.dart';
import 'package:test_flutter/util/consant/navigation_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: NavigationRoute.instance.initRoute,
      onGenerateRoute: NavigationRoute.instance.onGenerateRoute,
    );
  }
}
