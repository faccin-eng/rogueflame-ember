import 'package:flutter/material.dart';

enum _PadDirection { neutral, up, down, left, right }

class GameControls extends StatefulWidget {
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

  @override
  State<GameControls> createState() => _GameControlsState();
}

class _GameControlsState extends State<GameControls> {
  _PadDirection _activeDirection = _PadDirection.neutral;

  void _releaseDirection(_PadDirection direction) {
    switch (direction) {
      case _PadDirection.left:
        widget.onLeftReleased();
        break;
      case _PadDirection.right:
        widget.onRightReleased();
        break;
      case _PadDirection.down:
        widget.onDownReleased();
        break;
      case _PadDirection.neutral:
      case _PadDirection.up:
        break;
    }
  }

  void _applyDirection(_PadDirection direction) {
    if (direction == _activeDirection) return;

    _releaseDirection(_activeDirection);

    switch (direction) {
      case _PadDirection.left:
        widget.onLeftPressed();
        break;
      case _PadDirection.right:
        widget.onRightPressed();
        break;
      case _PadDirection.down:
        widget.onDownPressed();
        break;
      case _PadDirection.up:
        widget.onJump();
        break;
      case _PadDirection.neutral:
        break;
    }

    setState(() {
      _activeDirection = direction;
    });
  }

  void _resetPad() {
    _releaseDirection(_activeDirection);
    if (_activeDirection != _PadDirection.neutral) {
      setState(() {
        _activeDirection = _PadDirection.neutral;
      });
    }
  }

  _PadDirection _directionFromPosition(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    const deadzone = 22.0;

    if (dx.abs() < deadzone && dy.abs() < deadzone) {
      return _PadDirection.neutral;
    }

    if (dx.abs() > dy.abs()) {
      return dx < 0 ? _PadDirection.left : _PadDirection.right;
    }

    return dy < 0 ? _PadDirection.up : _PadDirection.down;
  }

  Widget _directionButton({
    required IconData icon,
    required bool isActive,
    Color color = Colors.white38,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 80),
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: isActive ? Colors.white60 : color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? Colors.white : Colors.white54,
          width: isActive ? 2.2 : 1.5,
        ),
      ),
      child: Icon(icon, size: 34, color: Colors.white),
    );
  }

  Widget _buildDigitalPad() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (details) =>
          _applyDirection(_directionFromPosition(details.localPosition, const Size(180, 180))),
      onPanUpdate: (details) =>
          _applyDirection(_directionFromPosition(details.localPosition, const Size(180, 180))),
      onPanEnd: (_) => _resetPad(),
      onPanCancel: _resetPad,
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
                isActive: _activeDirection == _PadDirection.up,
              ),
            ),
            Positioned(
              left: 0,
              child: _directionButton(
                icon: Icons.keyboard_arrow_left,
                isActive: _activeDirection == _PadDirection.left,
              ),
            ),
            Positioned(
              right: 0,
              child: _directionButton(
                icon: Icons.keyboard_arrow_right,
                isActive: _activeDirection == _PadDirection.right,
              ),
            ),
            Positioned(
              bottom: 0,
              child: _directionButton(
                icon: Icons.keyboard_arrow_down,
                isActive: _activeDirection == _PadDirection.down,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 28,
          left: 20,
          child: _buildDigitalPad(),
        ),
        Positioned(
          bottom: 40,
          right: 50,
          child: GestureDetector(
            onTap: widget.onAttack,
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
