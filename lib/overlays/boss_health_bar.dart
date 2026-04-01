import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../screens/ember_quest.dart';

class BossHealthBar extends PositionComponent with HasGameReference<EmberQuestGame> {
  BossHealthBar({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 6,
  });

  late RectangleComponent _backgroundBar;
  late RectangleComponent _healthFillBar;
  late TextComponent _bossNameLabel;
  final double barWidth = 300.0;
  final double barHeight = 30.0;
  final double padding = 20.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Position at bottom center of viewport
    final barX = (game.size.x - barWidth) / 2;
    final barY = game.size.y - barHeight - padding;

    // Boss name label
    _bossNameLabel = TextComponent(
      text: 'FROG KING',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      anchor: Anchor.topCenter,
      position: Vector2(barWidth / 2, -30),
    );
    add(_bossNameLabel);

    // Background bar (dark gray)
    _backgroundBar = RectangleComponent(
      size: Vector2(barWidth, barHeight),
      position: Vector2(0, 0),
      paint: Paint()..color = const Color.fromRGBO(60, 60, 60, 1),
      anchor: Anchor.topLeft,
    );
    add(_backgroundBar);

    // Health fill bar (green to red gradient)
    _healthFillBar = RectangleComponent(
      size: Vector2(barWidth, barHeight),
      position: Vector2(0, 0),
      paint: Paint()..color = const Color.fromRGBO(0, 255, 0, 1),
      anchor: Anchor.topLeft,
    );
    add(_healthFillBar);

    position = Vector2(barX, barY);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (!game.bossActive) {
      removeFromParent();
      return;
    }

    // Update fill bar width based on boss health
    final healthRatio = game.bossHealth / game.bossMaxHealth;
    _healthFillBar.size.x = barWidth * healthRatio.clamp(0.0, 1.0);

    // Change color from green to red as health decreases
    final green = (255 * healthRatio).toInt().clamp(0, 255);
    final red = 255 - green;
    _healthFillBar.paint.color = Color.fromRGBO(red, green, 0, 1);
  }
}
