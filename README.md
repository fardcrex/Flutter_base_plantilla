# base_proyect

A new Flutter project.

## Getting Started

```
flutter create --org.organizacion nombre_proyecto
```

## Packages

### Dependencias

- [freezed_annotation](https://pub.dev/packages/freezed_annotation)
- [built_collection](https://pub.dev/packages/built_collection)
- [json_annotation](https://pub.dev/packages/json_annotation)
- [flutter_flavor](https://pub.dev/packages/flutter_flavor)
- [get_it](https://pub.dev/packages/get_it)
- [dartz](https://pub.dev/packages/lint)

### Dev Dependencias

- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [build_runner](https://pub.dev/packages/build_runner)
- [freezed](https://pub.dev/packages/freezed)
- [lint](https://pub.dev/packages/lint)

## Configuración simple

### Nombre de la App

#### configurar el archivo android\app\src\main\AndroidManifest.xml

```xml
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="El_nombre_de_la_app"
```

### Icono de la App

#### configurar el archivo pubspec.yaml

```yaml
dev_dependencies:
  flutter_launcher_icons: "^0.8.0"

flutter_icons:
  #  image_path: "assets/images/icon-128x128.png"
  image_path_android: "assets/icon/icon.png"
  image_path_ios: "assets/icon/icon.png"
  android: true
  ios: true
  adaptive_icon_background: "assets/icon/background.png"
  adaptive_icon_foreground: "assets/icon/foreground.png"
```

#### colocar las respectivas imagenes en assets/icon/ y run

```
flutter pub run flutter_launcher_icons:main
```

### Notification icon de la App

#### configurar el archivo android\app\src\main\AndroidManifest.xml

```xml
 <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="El_nombre_de_la_app"
         android:icon="@mipmap/ic_launcher">
        <meta-data
            android:name="com.google.firebase.messaging.default_notification_icon"
            android:resource="@mipmap/ic_notification" />
```

### Splash screen

#### ruta del archivo 'android\app\src\main\res\drawable\launch_background.xml'

#### agrega tus launch image example launch_image.png y launch_text.png

```xml
<?xml version="1.0" encoding="utf-8"?>

<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
   <item android:drawable="@drawable/bg_color" />

    <!-- You can insert your own image assets here -->
    <item>
        <bitmap
            android:gravity="center"
            android:src="@drawable/launch_image" />
    </item>
     <item android:bottom="40dp">
        <bitmap
            android:gravity="bottom"
            android:src="@drawable/launch_text" />
    </item>
</layer-list>

```

#### background Color in android\app\src\main\res\drawable\bg_color.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <solid android:color="@color/primary" />
</shape>
```

#### background Color in android\app\src\main\res\values\colors.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="primary">#EAF2FF</color>
</resources>
```

### Lint

```yaml
dev_dependencies:
  lint: ^1.3.0
```

#### Create a analysis_options.yaml file in the root of your project and import the lint rules:

```yaml
include: package:lint/analysis_options.yaml
```

## Configuración con Flavors

### Flavors

#### Agregar lo siguiente al archivo android\app\build.gradle para configurar los Flavors

```gradle
flavorDimensions "flavor-type"

    productFlavors{
        prod {
            dimension "flavor-type"
            applicationId "com.organizacion.name_package"
            versionCode flutterVersionCode.toInteger()
            versionName flutterVersionName
            manifestPlaceholders = [appName: "Flavor"]
        }
        dev {
            dimension "flavor-type"
            applicationIdSuffix ".dev"
            versionCode flutterVersionCode.toInteger()
            versionNameSuffix "-dev"
            manifestPlaceholders = [appName: "Flavor DEV"]
        }
        tst {
            dimension "flavor-type"
            applicationIdSuffix ".tst"
            versionCode flutterVersionCode.toInteger()
            versionNameSuffix "-tst"
            manifestPlaceholders = [appName: "Flavor TST"]
        }
    }
```

### Icono de los Flavors

#### create files flutter_launcher_icons-[name_folder] para cada Flavor, examples:

- flutter_launcher_icons-prod.yaml
- flutter_launcher_icons-dev.yaml
- flutter_launcher_icons-tst.yaml

colocar las respectivas imagenes en assets/icon/ para cada Flavor y run

```
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-prod.yaml
```

### Name App para cada Flavor

#### configurar el archivo android\app\src\main\AndroidManifest.xml

```xml
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="@string/app_name"
```

#### create files para cada Flavor

- android\app\src\prod\res\values\strings.xml
- android\app\src\dev\res\values\strings.xml
- android\app\src\tst\res\values\strings.xml

```xml
    <?xml version="1.0" encoding="utf-8"?>
    <resources>
        <string name="app_name">Nombre de la App</string>
    </resources>
```

### Splash screen

#### add file styles.xml para cada Flavor in

- android\app\src\\[Flavor]\res\values\styles.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>

    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:windowBackground">@drawable/launch_background</item>
    </style>

</resources>
```

#### add file launch_background.xml y sus launch_image in

- android\app\src\\[Flavor]\res\drawable\

```xml
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@color/colorbg" />

    <item>
        <bitmap
            android:gravity="center"
            android:src="@drawable/launch_image" />
    </item>

</layer-list>
```

#### background Color in

- android\app\src\\[Flavor]res\values\colors.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="colorbg">#FFFFFF</color>
</resources>
```

### Comandos para correr y build los Flavors

```
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor tst -t lib/main_tst.dart
flutter run --flavor prod -t lib/main.dart
```

```
flutter build apk --flavor prod -t lib/main.dart
```

### Comandos para build runner

```
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Visual Studio Code

configuración simple launch.json example

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter Test",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "program": "lib/main.dart",
      "args": ["--flavor", "tst"]
    },
    {
      "name": "Flutter Dev",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "program": "lib/main.dart",
      "args": ["--flavor", "dev"]
    },
    {
      "name": "Flutter Prod",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "program": "lib/main.dart",
      "args": ["--flavor", "prod"]
    }
  ]
}
```

### Android Studio

[Check this article for android Studio Setup](https://cogitas.net/creating-flavors-of-a-flutter-app/)
