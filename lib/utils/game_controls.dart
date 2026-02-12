import 'package:flutter/material.dart';

class GameControls extends StatelessWidget {
  final VoidCallback onLeftPressed;
  final VoidCallback onLeftReleased;
  final VoidCallback onRightPressed;
  final VoidCallback onRightReleased;
  final VoidCallback onJump;

  const GameControls({
    super.key,
    required this.onLeftPressed,
    required this.onLeftReleased,
    required this.onRightPressed,
    required this.onRightReleased,
    required this.onJump,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Botão esquerda
        Positioned(
          bottom: 40,
          left: 20,
          child: GestureDetector(
            onTapDown: (_) => onLeftPressed(),
            onTapUp: (_) => onLeftReleased(),
            onTapCancel: onLeftReleased,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white38,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
            ),
          ),
        ),
        // Botão direita
        Positioned(
          bottom: 40,
          left: 110,
          child: GestureDetector(
            onTapDown: (_) => onRightPressed(),
            onTapUp: (_) => onRightReleased(),
            onTapCancel: onRightReleased,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white38,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, size: 40, color: Colors.white),
            ),
          ),
        ),
        // Botão pular
        Positioned(
          bottom: 40,
          right: 50,
          child: GestureDetector(
            onTap: onJump,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white38,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_upward, size: 40, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}