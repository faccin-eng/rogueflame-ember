import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gamepads/gamepads.dart';

const double _kAxisDeadzone = 0.25;

class GamepadControls {
  final VoidCallback onLeftPressed;
  final VoidCallback onLeftReleased;
  final VoidCallback onRightPressed;
  final VoidCallback onRightReleased;
  final VoidCallback onDownPressed;
  final VoidCallback onDownReleased;
  final VoidCallback onJump;
  final VoidCallback onAttack;

  StreamSubscription<NormalizedGamepadEvent>? _subscription;
  int _lastHorizontal = 0;
  bool _isDownPressed = false;

  GamepadControls({
    required this.onLeftPressed,
    required this.onLeftReleased,
    required this.onRightPressed,
    required this.onRightReleased,
    required this.onDownPressed,
    required this.onDownReleased,
    required this.onJump,
    required this.onAttack,
  });

  void attach() {
    _subscription = Gamepads.normalizedEvents.listen(_handleEvent);
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _lastHorizontal = 0;
    _applyDown(false);
  }

  void _handleEvent(NormalizedGamepadEvent event) {
    // Botão de pulo: A (Xbox) / Cross (PlayStation)
    if (event.button == GamepadButton.a) {
      if (event.value > 0.5) onJump();
      return;
    }

    // Botão de ataque: B (Xbox) / Circle (PlayStation)
    if (event.button == GamepadButton.b) {
      if (event.value > 0.5) onAttack();
      return;
    }

    // D-pad esquerdo/direito
    if (event.button == GamepadButton.dpadLeft) {
      _applyHorizontal(event.value > 0.5 ? -1 : 0);
      return;
    }
    if (event.button == GamepadButton.dpadRight) {
      _applyHorizontal(event.value > 0.5 ? 1 : 0);
      return;
    }
    if (event.button == GamepadButton.dpadDown) {
      _applyDown(event.value > 0.5);
      return;
    }

    if (event.axis == GamepadAxis.leftStickX) {
      final v = event.value;
      if (v < -_kAxisDeadzone) {
        _applyHorizontal(-1);
      } else if (v > _kAxisDeadzone) {
        _applyHorizontal(1);
      } else {
        _applyHorizontal(0);
      }
      return;
    }

    if (event.axis == GamepadAxis.leftStickY) {
      final v = event.value;
      _applyDown(v > _kAxisDeadzone);
    }
  }

  void _applyHorizontal(int direction) {
    if (direction == _lastHorizontal) return;
    _lastHorizontal = direction;
    if (direction == -1) {
      onLeftPressed();
    } else if (direction == 1) {
      onRightPressed();
    } else {
      onLeftReleased();
    }
  }

  void _applyDown(bool isPressed) {
    if (isPressed == _isDownPressed) return;
    _isDownPressed = isPressed;
    if (isPressed) {
      onDownPressed();
    } else {
      onDownReleased();
    }
  }
}
