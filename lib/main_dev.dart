import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'app/home_page.dart';
import 'injection.dart';

Future main() async {
  const portLocal = '8086';

  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    name: 'Dev',
    color: Colors.orange[900],
    location: BannerLocation.bottomStart,
    variables: {
      Port.androidPlatform: '10.0.2.2:$portLocal',
      Port.anotherPlatform: 'localhost:$portLocal',
    },
  );

  await configureInjection(const Env.dev());

  runApp(FlavorBanner(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffFFF1EA),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Flutter Testing Config',
      home: const HomePage(
        titlePage: 'Flavor Desarrollo',
      ),
    );
  }
}
