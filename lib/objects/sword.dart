import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import '../screens/ember_quest.dart';

class Sword extends SpriteAnimationComponent with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  Sword({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad(){
   animation = SpriteAnimation.fromFrameData(
    game.images.fromCache('sword.png'),
    SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 0.70, 
      textureSize: Vector2.all(16),
      ),
      );
    // sprite = Sprite(starImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset +(size.x / 2), game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
    add(CircleHitbox(collisionType: CollisionType.passive));
    final aura = CircleComponent(
      radius: 28,
      anchor: Anchor.center,
      position: Vector2(32, 32),
      paint: Paint()
      ..color = const Color(0x55FF0000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );
    add(aura);

    add(
      ScaleEffect.by(
        Vector2.all(1.1),
        EffectController(
          duration: 0.8,
          reverseDuration: 0.8,
          infinite: true,
        ),
      ),
    );
    
 
  }

  @override
  void update(double dt){
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    super.update(dt);
  }

}