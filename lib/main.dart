import 'package:flutter/material.dart';

import 'app/home_page.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
