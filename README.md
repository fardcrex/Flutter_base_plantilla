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

### Splash screen

#### ruta del archivo 'android\app\src\main\res\drawable\launch_background.xml'

#### agrega tus launch image example launch_image.png y launch_text.png

```
<?xml version="1.0" encoding="utf-8"?>

<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@color/colorbg" />

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

#### background Color in android\app\src\main\res\values\colors.xml

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="colorbg">#EAF2FF</color>
</resources>
```

### Nombre de la App

#### configurar el archivo android\app\src\main\AndroidManifest.xml

```
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="El_nombre_de_la_app"
```

### Icono de la App

#### configurar el archivo pubspec.yaml

```
flutter_icons:
  #  image_path: "assets/images/icon-128x128.png"
  image_path_android: "assets/icon/icon.png"
  image_path_ios: "assets/icon/icon.png"
  android: true
  ios: true
  adaptive_icon_background: "assets/icon/background.png"
  adaptive_icon_foreground: "assets/icon/foreground.png"
```

#### run

```
flutter pub run flutter_launcher_icons:main
```
