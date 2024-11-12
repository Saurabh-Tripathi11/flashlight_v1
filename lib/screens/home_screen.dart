// lib/screens/home_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/timer_display.dart';
import '../widgets/flashlight_button.dart';
import '../services/flashlight_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlashlightService _flashlightService = FlashlightService();
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _isSOSActive = false;

  @override
  void dispose() {
    _timer?.cancel();
    _flashlightService.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_isSOSActive) return;

    setState(() {
      _remainingSeconds += 30;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _flashlightService.turnOff();
          timer.cancel();
        }
      });
    });

    _flashlightService.turnOn();
  }

  void _resetTimer() {
    setState(() {
      _remainingSeconds = 0;
      _isSOSActive = false;
      _timer?.cancel();
      _timer = null;
    });
    _flashlightService.stopSOS();
  }

  void _toggleSOS() {
    setState(() {
      _isSOSActive = !_isSOSActive;
      if (_isSOSActive) {
        _timer?.cancel();
        _timer = null;
        _remainingSeconds = 0;
        _flashlightService.startSOS();
      } else {
        _flashlightService.stopSOS();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimerDisplay(remainingSeconds: _remainingSeconds),
            FlashlightButton(
              onPressed: _isSOSActive ? null : _startTimer,
              isActive: _remainingSeconds > 0 || _isSOSActive,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _toggleSOS,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isSOSActive ? Colors.red : Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('SOS'),
                  ),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}