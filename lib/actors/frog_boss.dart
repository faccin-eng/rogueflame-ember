import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:rogueflame/objects/platform_block.dart';
import 'package:rogueflame/objects/ground_block.dart';
import 'package:rogueflame/actors/frog_spit.dart';
import 'package:rogueflame/actors/ember.dart';
import '../screens/ember_quest.dart';

enum BossState { idle, move, spit, tongue, hurt, heal }

class FrogBoss extends SpriteAnimationGroupComponent<BossState>
    with CollisionCallbacks, HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;
  final Vector2 velocity = Vector2.zero();

  int health = 10;
  final int maxHealth = 10;
  bool isHurt = false;
  bool hasHealed = false;
  final double gravity = 960;
  final double terminalVelocity = 150;

  final double patrolSpeed = 80.0;
  double _stateTimer = 0.0;
  BossState _currentAction = BossState.idle;

  FrogBoss({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(384), anchor: Anchor.bottomCenter);

  @override
  Future<void> onLoad() async {
    final idleAnim = await _loadAnimation('bosses/frog/frogger_idle.png');
    final moveAnim = await _loadAnimation('bosses/frog/frogger_move.png');
    final spitAnim = await _loadAnimation('bosses/frog/frogger_spit.png', loop: false);
    final tongueAnim = await _loadAnimation('bosses/frog/frogger_tongue.png', loop: false);
    final hurtAnim = await _loadAnimation('bosses/frog/frogger_hurt.png', loop: false);
    final healAnim = await _loadAnimation('bosses/frog/frogger_heal.png', loop: false);

    animations = {
      BossState.idle: idleAnim,
      BossState.move: moveAnim,
      BossState.spit: spitAnim,
      BossState.tongue: tongueAnim,
      BossState.hurt: hurtAnim,
      BossState.heal: healAnim,
    };
    current = BossState.idle;

    position = Vector2(
      (gridPosition.x * 64) + xOffset + 192,
      game.size.y - (gridPosition.y * 64) - 30,
    );
    // No initial flip — sprite default orientation faces left (toward the player)
    add(RectangleHitbox(collisionType: CollisionType.active));
  }

  Future<SpriteAnimation> _loadAnimation(String path, {bool loop = true}) async {
    final image = game.images.fromCache(path);
    final frameCount = image.width ~/ 128;
    double stepTime = 0.1;
    if (path.contains('idle')) stepTime = 0.2;
    if (path.contains('heal')) stepTime = 0.05;
    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: frameCount,
        stepTime: stepTime,
        textureSize: Vector2.all(128),
        amountPerRow: frameCount,
        loop: loop,
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlatformBlock || other is GroundBlock) {
      if (intersectionPoints.isNotEmpty) {
        final minY = intersectionPoints.fold(
          double.infinity, (min, p) => p.y < min ? p.y : min);
        if (absoluteCenter.y < minY) {
          position.y = minY;
          velocity.y = velocity.y.clamp(double.negativeInfinity, 0);
        }
      }
    }
    if (other is EmberPlayer) {
      game.ember?.hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  void takeHit() {
    if (isHurt) return;
    isHurt = true;
    health--;
    game.bossHealth = health;

    if (health <= 0) {
      game.bossActive = false;
      game.bossDefeated = true;
      _currentAction = BossState.hurt;
      current = BossState.hurt;
      add(OpacityEffect.fadeOut(
        EffectController(duration: 1.5),
      )..onComplete = () {
        removeFromParent();
      });
    } else {
      _currentAction = BossState.hurt;
      current = BossState.hurt;
      _stateTimer = 0.0;
      // Brief dim without rapid blinking
      add(OpacityEffect.to(
        0.4,
        EffectController(duration: 0.15),
      )..onComplete = () {
        add(OpacityEffect.to(
          1.0,
          EffectController(duration: 0.15),
        )..onComplete = () {
          isHurt = false;
          _currentAction = BossState.idle;
          current = BossState.idle;
          _stateTimer = 0.0;
        });
      });
    }
  }

  @override
  void update(double dt) {
    velocity.y += gravity * dt;
    velocity.y = velocity.y.clamp(-terminalVelocity, terminalVelocity);
    _stateTimer += dt;

    // Always face the player — direct assignment avoids per-frame toggle flickering.
    // scale.x = 1.0 → default (left), scale.x = -1.0 → flipped (right).
    // If the sprite ends up reversed, swap the 1.0 and -1.0 here.
    final playerX = game.ember?.position.x ?? position.x;
    scale.x = playerX > position.x ? -1.0 : 1.0;

    switch (_currentAction) {
      case BossState.idle:
        if (_stateTimer >= 1.5) {
          final rand = Random().nextInt(3);
          if (rand == 0) {
            _currentAction = BossState.move;
          } else if (rand == 1) {
            _currentAction = BossState.spit;
          } else {
            _currentAction = BossState.tongue;
          }
          current = _currentAction;
          _stateTimer = 0.0;
        }
        velocity.x = game.objectSpeed;
        break;

      case BossState.move:
        if (_stateTimer >= 2.0) {
          _currentAction = BossState.idle;
          current = BossState.idle;
          _stateTimer = 0.0;
        } else {
          final dir = playerX > position.x ? 1 : -1;
          velocity.x = game.objectSpeed + dir * patrolSpeed;
        }
        break;

      case BossState.spit:
        if (_stateTimer >= 0.5 && _stateTimer < 0.6) {
          _spawnSpit();
        }
        if (_stateTimer >= 1.0) {
          _currentAction = BossState.idle;
          current = BossState.idle;
          _stateTimer = 0.0;
        }
        velocity.x = game.objectSpeed;
        break;

      case BossState.tongue:
        if (_stateTimer >= 0.5 && _stateTimer < 0.6) {
          _tongueAttack();
        }
        if (_stateTimer >= 1.0) {
          _currentAction = BossState.idle;
          current = BossState.idle;
          _stateTimer = 0.0;
        }
        velocity.x = game.objectSpeed;
        break;

      case BossState.hurt:
        velocity.x = game.objectSpeed;
        break;

      case BossState.heal:
        if (_stateTimer >= 1.0) {
          _currentAction = BossState.idle;
          current = BossState.idle;
          _stateTimer = 0.0;
        }
        velocity.x = game.objectSpeed;
        break;
    }

    // Heal trigger
    if (!hasHealed && health <= 3) {
      hasHealed = true;
      _currentAction = BossState.heal;
      current = BossState.heal;
      _stateTimer = 0.0;
      health = (health + 2).clamp(0, maxHealth);
      game.bossHealth = health;
    }

    position += velocity * dt;

    // Floor constraint — boss arena is flat ground
    final groundY = game.size.y - 64;
    if (position.y > groundY) {
      position.y = groundY;
      velocity.y = 0;
    }

    if (position.x < -size.x) { game.bossActive = false; removeFromParent(); }
    if (position.y > game.size.y + size.y) { game.bossActive = false; removeFromParent(); }
    super.update(dt);
  }

  void _spawnSpit() {
    final dir = (game.ember?.position.x ?? position.x) > position.x ? 1 : -1;
    final spit = FrogSpit(
      position: position.clone(),
      direction: dir,
    );
    game.world.add(spit);
  }

  void _tongueAttack() {
    final player = game.ember;
    if (player != null && (player.position - position).length < 100) {
      game.ember?.hit();
    }
  }
}
