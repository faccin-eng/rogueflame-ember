import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/segment_manager.dart';
import '../screens/ember_quest.dart';
import '../actors/frog_boss.dart';
import '../overlays/boss_health_bar.dart';
import 'platform_block.dart';
import 'river.dart';
import 'star.dart';
import 'sword.dart';
import '../actors/water_enemy.dart';

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
      if (!game.bossSegmentLoaded && game.segmentsLoaded >= 8) {
        // Load boss arena
        for (final block in segmentBoss) {
          switch (block.blockType) {
            case GroundBlock:
              game.world.add(GroundBlock(
                gridPosition: block.gridPosition,
                xOffset: game.lastBlockXPosition,
              ));
              break;
            case PlatformBlock:
              game.world.add(PlatformBlock(
                gridPosition: block.gridPosition,
                xOffset: game.lastBlockXPosition,
              ));
              break;
            case River:
              game.world.add(River(
                gridPosition: block.gridPosition,
                xOffset: game.lastBlockXPosition,
              ));
              break;
            case Star:
              game.world.add(Star(
                gridPosition: block.gridPosition,
                xOffset: game.lastBlockXPosition,
              ));
              break;
            case Sword:
              if (!game.swordSpawned) {
                game.world.add(Sword(
                  gridPosition: block.gridPosition,
                  xOffset: game.lastBlockXPosition,
                ));
                game.swordSpawned = true;
              }
              break;
            case WaterEnemy:
              game.world.add(WaterEnemy(
                gridPosition: block.gridPosition,
                xOffset: game.lastBlockXPosition,
              ));
              break;
            case BossBlock:
              final boss = FrogBoss(
                gridPosition: block.gridPosition,
                xOffset: game.lastBlockXPosition,
              );
              game.world.add(boss);
              game.bossActive = true;
              game.camera.viewport.add(BossHealthBar());
              break;
          }
        }
        game.bossSegmentLoaded = true;
      } else {
        game.loadGameSegments(
          Random().nextInt(segments.length),
          game.lastBlockXPosition,
        );
      }
    }
  }

    super.update(dt);

  }
 
}