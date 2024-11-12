// lib/widgets/timer_display.dart
import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int remainingSeconds;

  const TimerDisplay({Key? key, required this.remainingSeconds}) : super(key: key);

  String _formatTime() {
    if (remainingSeconds < 60) {
      return '$remainingSeconds seconds';
    } else {
      final minutes = remainingSeconds ~/ 60;
      final seconds = remainingSeconds % 60;

      // Handle singular/plural for minutes
      final minuteText = minutes == 1 ? 'minute' : 'minutes';

      // If seconds is 0, only show minutes
      if (seconds == 0) {
        return '$minutes $minuteText';
      }

      // Handle singular/plural for seconds
      final secondText = seconds == 1 ? 'second' : 'seconds';

      return '$minutes $minuteText $seconds $secondText';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        _formatTime(),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}