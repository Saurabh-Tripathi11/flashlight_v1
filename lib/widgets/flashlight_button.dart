// lib/widgets/flashlight_button.dart
import 'package:flutter/material.dart';

class FlashlightButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isActive;

  const FlashlightButton({
    Key? key,
    required this.onPressed,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.yellow : Colors.grey,
          boxShadow: isActive
              ? [
            BoxShadow(
              color: Colors.yellow.withOpacity(0.6),
              spreadRadius: 10,
              blurRadius: 15,
            )
          ]
              : null,
        ),
        child: Icon(
          Icons.flashlight_on,
          size: 80,
          color: isActive ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
