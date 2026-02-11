import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/segment_manager.dart';
import '../screens/ember_quest.dart';

class GroundBlock extends SpriteComponent with HasGameReference<EmberQuestGame> {
  final UniqueKey _blockKey = UniqueKey();
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  GroundBlock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    final groundImage = game.images.fromCache('ground.png');
    sprite = Sprite(groundImage);
    position = Vector2(
      gridPosition.x * size.x + xOffset,
      game.size.y - gridPosition.y * size.y,
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    if (gridPosition.x == 9 && position.x > game.lastBlockXPosition) {
      game.lastBlockKey = _blockKey;
      game.lastBlockXPosition = position.x + size.x;
}
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;

    if (gridPosition.x == 9){
      if (game.lastBlockKey == _blockKey) {
        game.lastBlockXPosition = position.x + size.x -10;
      }
    }
     if (position.x < -size.x){
    removeFromParent();
    if (gridPosition.x == 0){
      game.loadGameSegments(
      Random().nextInt(segments.length),
      game.lastBlockXPosition,
      );
    }
  }

    super.update(dt);

  }
 
}