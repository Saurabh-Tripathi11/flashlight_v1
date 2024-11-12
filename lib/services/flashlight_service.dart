// lib/services/flashlight_service.dart
import 'package:torch_light/torch_light.dart';
import 'dart:async';

class FlashlightService {
  Timer? _sosTimer;
  bool _isSOSActive = false;

  Future<void> turnOn() async {
    if (_isSOSActive) return;
    try {
      await TorchLight.enableTorch();
    } catch (e) {
      print('Error turning on flashlight: $e');
    }
  }

  Future<void> turnOff() async {
    try {
      await TorchLight.disableTorch();
    } catch (e) {
      print('Error turning off flashlight: $e');
    }
  }

  void startSOS() {
    _isSOSActive = true;
    _executeSOS();
  }

  void _executeSOS() async {
    if (!_isSOSActive) return;

    // Three short flashes
    for (int i = 0; i < 3; i++) {
      if (!_isSOSActive) return;
      await TorchLight.enableTorch();
      await Future.delayed(const Duration(milliseconds: 200));
      await TorchLight.disableTorch();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    await Future.delayed(const Duration(milliseconds: 300)); // Pause between sequences

    // Three long flashes
    for (int i = 0; i < 3; i++) {
      if (!_isSOSActive) return;
      await TorchLight.enableTorch();
      await Future.delayed(const Duration(milliseconds: 500));
      await TorchLight.disableTorch();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    await Future.delayed(const Duration(milliseconds: 300)); // Pause between sequences

    // Three short flashes again
    for (int i = 0; i < 3; i++) {
      if (!_isSOSActive) return;
      await TorchLight.enableTorch();
      await Future.delayed(const Duration(milliseconds: 200));
      await TorchLight.disableTorch();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    await Future.delayed(const Duration(milliseconds: 1000)); // Long pause before repeating

    // If still active, repeat the pattern
    if (_isSOSActive) {
      _executeSOS();
    }
  }

  void stopSOS() {
    _isSOSActive = false;
    _sosTimer?.cancel();
    _sosTimer = null;
    turnOff();
  }

  void dispose() {
    stopSOS();
    turnOff();
  }
}