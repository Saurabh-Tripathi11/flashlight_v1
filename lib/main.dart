// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_light/torch_light.dart';
import 'dart:async';
import 'screens/home_screen.dart';

void main() {
  runApp(const FlashlightApp());
  WidgetsFlutterBinding.ensureInitialized(); // Add this line

  // Add these lines to force portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const FlashlightApp());
  });
}

class FlashlightApp extends StatelessWidget {
  const FlashlightApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashlight App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}
