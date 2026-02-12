import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import '../screens/ember_quest.dart';

class River extends SpriteComponent with HasGameReference<EmberQuestGame>{
  final Vector2 gridPosition;
  double xOffset;
  final Vector2 velocity = Vector2.zero();

  River({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    final riverImage = game.images.fromCache('river.png'); 
      sprite = Sprite(riverImage);
      position = Vector2(
        (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
      );
      add(
      SizeEffect.by(
        Vector2(0,-3),
        EffectController(
          duration: 1.8,
          reverseDuration: 1.8,
          infinite: true,
          curve: Curves.easeOut,
        ),
      ),
    );
      add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt){
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();

    
    super.update(dt);
  }
}