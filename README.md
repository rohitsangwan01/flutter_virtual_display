# Flutter Virtual Display

This is a Flutter plugin that allows you to create a virtual display.

### Installation

To use this plugin, add `flutter_virtual_display` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

### Usage

Create a virtual display

```dart
var displayId = await FlutterVirtualDisplay.createDisplay(
                        name: "Virtual Display",
                        width: 1920,
                        height: 1080,
                    );
```

To remove this display

```dart
    FlutterVirtualDisplay.removeDisplay(displayId!);
```
                     
### TODO

Implement windows and linux support, currently only macos supported
