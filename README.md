# Flutter Virtual Display

[![flutter_virtual_display version](https://img.shields.io/pub/v/flutter_virtual_display?label=flutter_virtual_display)](https://pub.dev/packages/flutter_virtual_display)

This is a Flutter plugin that allows you to create a virtual display.

### Usage

Create a virtual display

```dart
// This will return displayId
await FlutterVirtualDisplay.createDisplay(
      name: "Virtual Display",
      width: 1920,
      height: 1080,
);
```

To remove this display

```dart
FlutterVirtualDisplay.removeDisplay(displayId);
```
                     
### TODO

Implement windows and linux support, currently only macos supported
