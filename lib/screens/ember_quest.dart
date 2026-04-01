
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:rogueflame/objects/river.dart';
import 'package:rogueflame/objects/sword.dart';
import 'package:rogueflame/overlays/hud.dart';
import 'package:rogueflame/overlays/boss_health_bar.dart';
import '../actors/ember.dart';
import '../actors/water_enemy.dart';
import '../actors/frog_boss.dart';

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
  final int maxHealth = 3;
  int health = 3;

  bool bossActive = false;
  bool bossDefeated = false;
  bool bossSegmentLoaded = false;
  int segmentsLoaded = 0;   // incremented in loadGameSegments
  int bossHealth = 10;
  final int bossMaxHealth = 10;

  VoidCallback? onGameOver;

  ParallaxComponent? parallaxBackground;
  bool swordSpawned = false;

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
      Rectangle.fromLTRB(0, -(canvasSize.y * 0.5), double.infinity, canvasSize.y * 0.5),
    );
    
    if (loadHud) camera.viewport.add(Hud());
  }

  void reset(){
    starsCollected = 0;
    health = maxHealth;
    swordSpawned = false;
    bossActive = false;
    bossDefeated = false;
    bossSegmentLoaded = false;
    segmentsLoaded = 0;
    bossHealth = bossMaxHealth;
    world.removeAll(world.children.toList());
    camera.viewport.removeAll(camera.viewport.children.toList());
    initializeGame(true);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset){
    segmentsLoaded++;
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
        case Sword:
         if (!swordSpawned) { world.add(
            Sword(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          swordSpawned = true;
          }
        case WaterEnemy:
        world.add(
          WaterEnemy(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ),
        );
        case BossBlock:
          final boss = FrogBoss(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          );
          world.add(boss);
          bossActive = true;
          camera.viewport.add(BossHealthBar());
      }
    }
  }

 

  @override
  Future<void> onLoad() async{
     parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/8.png'),
        ParallaxImageData('parallax/7.png'),
        ParallaxImageData('parallax/6.png'),
        ParallaxImageData('parallax/5.png'),
        ParallaxImageData('parallax/4.png'),
        ParallaxImageData('parallax/3.png'),
        ParallaxImageData('parallax/2.png'),
        ParallaxImageData('parallax/1.png'),
      ],
      baseVelocity: Vector2(0.1, 0),
      velocityMultiplierDelta: Vector2(1.1, 0),
      fill: LayerFill.height,
      alignment: Alignment.bottomCenter,
    );
    camera.backdrop.add(parallaxBackground!);

    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'sword.png',
      'swording.png',
      'river.png',
      'coin.png',
      'monster.png',
      'bosses/frog/frogger_idle.png',
      'bosses/frog/frogger_move.png',
      'bosses/frog/frogger_hurt.png',
      'bosses/frog/frogger_heal.png',
      'bosses/frog/frogger_spit.png',
      'bosses/frog/frogger_tongue.png',
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
    if (health <= 0 && !overlays.isActive('GameOver')){
      overlays.add('GameOver');
      WidgetsBinding.instance.addPostFrameCallback((_) {
      onGameOver?.call();
    });
      return;
    }
    if (parallaxBackground != null && ember != null){
    parallaxBackground?.parallax?.baseVelocity = Vector2(-objectSpeed * 0.3, 0);
    final cameraY = camera.viewfinder.position.y;
    parallaxBackground!.position.y = -cameraY * 0.029;
    }
    super.update(dt);
  }
}
