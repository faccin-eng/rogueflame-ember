
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:safeblock/objects/river.dart';
import 'package:safeblock/overlays/hud.dart';
import '../actors/ember.dart';
import '../actors/water_enemy.dart';
import '../objects/ground_block.dart';
import '../objects/platform_block.dart';
import '../objects/star.dart';
import '../utils/segment_manager.dart';

class EmberQuestGame extends FlameGame with HasCollisionDetection {

  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  EmberPlayer? ember;
  double objectSpeed = 0.0;

  int starsCollected = 0;
  int health = 3;

  @override
  Color backgroundColor(){
    return Colors.lightBlue.shade200;
  }

  void initializeGame(bool loadHud){
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 *i).toDouble());
    }

    ember = EmberPlayer(position: Vector2(128, canvasSize.y - 128),);
    world.add(ember!);
    camera.follow(ember!, verticalOnly: true, snap: true);
    camera.viewfinder.anchor = Anchor(0.16, 0.5);
    camera.setBounds(
      Rectangle.fromLTRB(0, 194, double.infinity, 0),
    );
    
    camera.viewport.add(Hud());
  }

  void reset(){
    starsCollected = 0;
    health = 3;
    initializeGame(false);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset){
    for (final block in segments[segmentIndex]) {
      switch (block.blockType){
        case GroundBlock:
          world.add(GroundBlock(gridPosition: block.gridPosition, 
            xOffset: xPositionOffset,
            ),
          );
        case River:
          world.add(River(gridPosition: block.gridPosition, 
            xOffset: xPositionOffset,
            ),
          );
        case PlatformBlock:
          world.add(PlatformBlock(
            gridPosition: block.gridPosition, 
            xOffset: xPositionOffset,
            ),
          );
        case Star:
          world.add(
            Star(
              gridPosition: block.gridPosition, 
              xOffset: xPositionOffset,
            ),
          );
        case WaterEnemy:
        world.add(
          WaterEnemy(
            gridPosition: block.gridPosition, 
            xOffset: xPositionOffset,
          ),
        );
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
      'river.png',
      'coin.png',
      'monster.png',
    ]);
    await FlameAudio.audioCache.load('great_dawn.mp3');
    await FlameAudio.audioCache.load('hit.wav');
    await FlameAudio.audioCache.load('jump.wav');
    await FlameAudio.audioCache.load('star.wav');
    await FlameAudio.audioCache.load('collision.wav');
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('great_dawn.mp3', volume: 0.5);



    initializeGame(true);
  }

  @override
  void update(double dt){
    if (health <= 0){
      overlays.add('GameOver');
    }
    super.update(dt);
  }
}