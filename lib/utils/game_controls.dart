import 'package:flutter/material.dart';


class GameControls extends StatelessWidget {
  final VoidCallback onLeftPressed;
  final VoidCallback onLeftReleased;
  final VoidCallback onRightPressed;
  final VoidCallback onRightReleased;
  final VoidCallback onDownPressed;
  final VoidCallback onDownReleased;
  final VoidCallback onJump;
  final VoidCallback onAttack;

  const GameControls({
    super.key,
    required this.onLeftPressed,
    required this.onLeftReleased,
    required this.onRightPressed,
    required this.onRightReleased,
    required this.onDownPressed,
    required this.onDownReleased,
    required this.onJump,
    required this.onAttack,
  });

  Widget _directionButton({
    required IconData icon,
    required VoidCallback onPressed,
    VoidCallback? onReleased,
    Color color = Colors.white38,
  }) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      onTapUp: (_) => onReleased?.call(),
      onTapCancel: onReleased,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white54, width: 1.5),
        ),
        child: Icon(icon, size: 34, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 28,
          left: 20,
          child: SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: _directionButton(
                    icon: Icons.keyboard_arrow_up,
                    onPressed: onJump,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: _directionButton(
                    icon: Icons.keyboard_arrow_left,
                    onPressed: onLeftPressed,
                    onReleased: onLeftReleased,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: _directionButton(
                    icon: Icons.keyboard_arrow_right,
                    onPressed: onRightPressed,
                    onReleased: onRightReleased,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: _directionButton(
                    icon: Icons.keyboard_arrow_down,
                    onPressed: onDownPressed,
                    onReleased: onDownReleased,
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 50,
          child: GestureDetector(
            onTap: onAttack,
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: const Text( '⚔️',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50),
            ),
            ),
          ),
        ),
      ],
    );
  }
}
