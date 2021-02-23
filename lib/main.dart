import 'package:flutter/material.dart';

import 'app/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(name: 'Prod', variables: {});

  await configureInjection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final hola = 33;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffEAF2FF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Flutter Simple Config',
      home: HomePage(),
    );
  }
}
