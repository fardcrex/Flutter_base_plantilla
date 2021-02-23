import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'app/home_page.dart';
import 'injection.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    name: 'Test',
    location: BannerLocation.bottomStart,
    color: Colors.green,
    variables: {},
  );

  await configureInjection(const Env.test());

  runApp(FlavorBanner(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xffEAFFF7),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Flutter Simple Config',
      home: const HomePage(
        titlePage: 'Flavor Testing',
      ),
    );
  }
}
