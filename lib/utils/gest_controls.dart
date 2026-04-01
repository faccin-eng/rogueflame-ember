import 'package:flutter/material.dart';

class GestControls extends StatefulWidget{
  final VoidCallback onLeftPressed;
  final VoidCallback onLeftReleased;
  final VoidCallback onRightPressed;
  final VoidCallback onRightReleased;
  final VoidCallback onJump;
  final VoidCallback onDownPressed;
  final VoidCallback onDownReleased;

  const GestControls({
    super.key,
    required this.onLeftPressed,
    required this.onLeftReleased,
    required this.onRightPressed,
    required this.onRightReleased,
    required this.onJump,
    required this.onDownPressed,
    required this.onDownReleased,
  });

  @override
  State<GestControls> createState() => _GestControlsState();
}

class _GestControlsState extends State<GestControls> {
  double? _startY;
  bool _isLeftPressed = false;
  bool _isRightPressed = false;

  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;

    return Listener(
      onPointerDown: (event) {
        _startY = event.position.dy;

        if (event.position.dx < screenWidth / 2){
          _isLeftPressed = true;
          widget.onLeftPressed();
        } else {
          _isRightPressed = true;
          widget.onRightPressed();
        }
      },

      onPointerMove: (event) {
        if (_startY != null) {
          final deltaY = event.position.dy - _startY!;

          if (deltaY < -30){
            widget.onJump();
            _startY = null;
          } else if (deltaY > 30) {
            widget.onDownPressed();
            _startY = null;
          }
        }
      },

      onPointerUp: (event) {
        _startY = null;
        if (_isLeftPressed){
          _isLeftPressed = false;
          widget.onLeftReleased();
        }
        if (_isRightPressed){
          _isRightPressed = false;
          widget.onRightReleased();
        }
        widget.onDownReleased();
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
