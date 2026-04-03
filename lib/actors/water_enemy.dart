import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:rogueflame/objects/platform_block.dart';
import 'package:rogueflame/objects/ground_block.dart';
import 'package:rogueflame/objects/heart_pickup.dart';
import '../screens/ember_quest.dart';

class WaterEnemy extends SpriteAnimationComponent with CollisionCallbacks, HasGameReference<EmberQuestGame>{
  static final Random _random = Random();
  final Vector2 gridPosition;
  double xOffset;
  final Vector2 velocity = Vector2.zero();

  int health = 2;
  bool isHurt = false;
  final double gravity = 960;
  final double terminalVelocity = 150;

  final double patrolSpeed = 60.0;
  final double patrolDuration = 2.0;
  double _patrolTimer = 0.0;
  int _patrolDirection = -1;

  WaterEnemy({
    required this.gridPosition,
    required this.xOffset,    
  }) : super(size: Vector2.all(64), anchor: Anchor.bottomCenter);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('monster.png'),
      SpriteAnimationData.sequenced(
        amount: 6, 
        stepTime: 2,
        textureSize: Vector2.all(48),
        amountPerRow: 3,
      ),
    );
        position = Vector2(
      (gridPosition.x * size.x) + xOffset + size.x / 2,
      game.size.y - (gridPosition.y * size.y) - 30,
    );
    add(RectangleHitbox(collisionType: CollisionType.active));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
    if (other is PlatformBlock || other is GroundBlock){
      if (intersectionPoints.isNotEmpty){
        // RectangleHitbox vs RectangleHitbox retorna 4 pontos — usar o Y mínimo
        // que corresponde ao topo do bloco de chão/plataforma
        final minY = intersectionPoints.fold(
          double.infinity, (min, p) => p.y < min ? p.y : min);
        // Somente corrigir se o centro do inimigo estiver acima do ponto de contato
        if (absoluteCenter.y < minY) {
          position.y = minY; // Ancora bottomCenter: position.y == borda inferior
          velocity.y = velocity.y.clamp(double.negativeInfinity, 0);
        }
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  void takeHit(){
    if (isHurt) return;
    isHurt = true;
    health--; 
    
    if (health <= 0){
      if (_random.nextDouble() < 0.4) {
        game.world.add(
          HeartPickup(
            position: position.clone() - Vector2(0, size.y * 0.45),
          ),
        );
      }
      add(
        OpacityEffect.fadeOut(
          EffectController(
          alternate: true,
          duration: 0.01,
          repeatCount: 3,
          ),
        ),
      );
      removeFromParent();
    } else {
      add(
        OpacityEffect.fadeOut(
          EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 3,
          ),
        )..onComplete = () {
          isHurt = false;
        }
      );
    }
  }

  @override
  void update(double dt){
    velocity.y += gravity * dt;
    velocity.y = velocity.y.clamp(-terminalVelocity, terminalVelocity);
    _patrolTimer += dt;
    if (_patrolTimer >= patrolDuration) {
      _patrolDirection *= -1;
      _patrolTimer = 0.0;
      flipHorizontally();
      animationTicker?.reset();
    }
    velocity.x = game.objectSpeed + _patrolDirection * patrolSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    if (position.y > game.size.y + size.y) removeFromParent();
    super.update(dt);
  }

}
