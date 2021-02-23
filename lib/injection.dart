import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:get_it/get_it.dart';

part 'injection.freezed.dart';

final getIt = GetIt.instance;

Future<void> configureInjection(Env environment) async {
//==================================================
//            Configuracines Iniciales
//==================================================
  environment.when(
    test: () => print(environment),
    dev: () {
      final flavorConfig = FlavorConfig.instance.variables;
      final android = flavorConfig[Port.androidPlatform] as String;
      final others = flavorConfig[Port.anotherPlatform] as String;
      print(android);
      print(others);
    },
    prod: () => print(environment),
  );
}

class Port {
  static const androidPlatform = 'android';
  static const anotherPlatform = 'another';
}

@freezed
abstract class Env with _$Env {
  const factory Env.dev() = Dev;
  const factory Env.prod() = Prod;
  const factory Env.test() = Test;
}
