// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_virtual_display/flutter_virtual_display.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? displayId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Virtual Display'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Virtual Display ID: $displayId"),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: displayId != null
                      ? null
                      : () async {
                          var result =
                              await FlutterVirtualDisplay.createDisplay(
                            name: "Virtual Display",
                            width: 1920,
                            height: 1080,
                          );
                          setState(() {
                            displayId = result;
                          });
                        },
                  child: const Text('Create Virtual Display'),
                ),
                ElevatedButton(
                  onPressed: displayId == null
                      ? null
                      : () {
                          FlutterVirtualDisplay.removeDisplay(displayId!);
                          setState(() {
                            displayId = null;
                          });
                        },
                  child: const Text('Remove Display'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
