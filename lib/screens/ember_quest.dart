
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:safeblock/actors/ember.dart';
import 'package:safeblock/actors/water_enemy.dart';
import 'package:safeblock/objects/ground_block.dart';
import 'package:safeblock/objects/platform_block.dart';
import 'package:safeblock/objects/star.dart';
import 'package:safeblock/utils/segment_manager.dart';

class EmberQuestGame extends FlameGame {
  @override
  Color backgroundColor(){
    return Colors.lightBlue.shade200;
  }
  late EmberPlayer _ember;
  double objectSpeed = 0.0;

  void initializeGame(){
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 *i).toDouble());
    }

    _ember = EmberPlayer(position: Vector2(128, canvasSize.y - 120),);
    world.add(_ember);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset){
    for (final block in segments[segmentIndex]) {
      switch (block.blockType){
        case GroundBlock:
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition, 
            xOffset: xPositionOffset
            ));
        case Star:
        case WaterEnemy:
      }
    }
  }

  @override
  Future<void> onLoad() async{
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    initializeGame();
  }
}