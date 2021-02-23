import 'package:flutter/material.dart';

import 'app/home_page.dart';
import 'injection.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection(const Env.prod());

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
      home: const HomePage(
        titlePage: 'Flavor Production',
      ),
    );
  }
}
