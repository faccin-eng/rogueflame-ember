import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:safeblock/actors/water_enemy.dart';
import 'package:safeblock/effects/splash_effect.dart';
import 'package:safeblock/objects/river.dart';
import 'package:safeblock/objects/star.dart';
import '../screens/ember_quest.dart';
import '../objects/ground_block.dart';
import '../objects/platform_block.dart';

class EmberPlayer extends SpriteAnimationComponent with CollisionCallbacks, HasGameReference<EmberQuestGame>{
  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);
   int horizontalDirection = 0;
   final Vector2 velocity = Vector2.zero();
   final Vector2 fromAbove = Vector2(0, -1);
   final double moveSpeed = 200;
   bool isOnGround = false;

   bool hasJumped = false;
   final double gravity = 16;
   final double jumpSpeed = 600;
   final double terminalVelocity = 150;

   bool hitByEnemy = false;

  void moveLeft(){
    horizontalDirection = -1;
  }
  void moveRight(){
    horizontalDirection = 1;
  }
  void stopMoving(){
    horizontalDirection = 0;
  }
  void jump(){
    hasJumped = true;
    
  }

  void hit(){
    if (!hitByEnemy) {
      game.health--;
      hitByEnemy = true;
      FlameAudio.play('hit.wav', volume: 0.4);
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 5,
          ),
      )..onComplete = () {
        hitByEnemy = false;
      }
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
    if (other is Star) {
      other.removeFromParent();
      game.starsCollected++;
      FlameAudio.play('star.wav', volume: 0.4);
    }
    if (other is WaterEnemy && !hitByEnemy){
      hit();
    }
    if (other is River){
      hit();
      game.world.add(SplashEffect(position: position.clone()));
    }
    if (other is GroundBlock || other is PlatformBlock){
      if (intersectionPoints.length == 2){
        final mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1))/2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        if (fromAbove.dot(collisionNormal) > 0.9){
          isOnGround = true;

        }
        position += collisionNormal.scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    velocity.y += gravity;
    if (hasJumped){
      if (isOnGround){
        velocity.y = -jumpSpeed;
        isOnGround = false;
        FlameAudio.play('jump.wav');
      }
      hasJumped = false;
    }
      velocity.y = velocity.y.clamp(-jumpSpeed, terminalVelocity);

    velocity.x = horizontalDirection * moveSpeed;
    
    
    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    game.objectSpeed = 0;
    if (position.x - 36 <= 0 && horizontalDirection < 0){
      velocity.x = 0;
    }
    if (position.x + 64 >= game.size.x / 2 && horizontalDirection > 0) {
      velocity.x = 0;
      game.objectSpeed = -moveSpeed;
    }

    if (position.y > game.size.y + size.y){
      game.health = 0;
      
    }

    if (game.health <= 0){
      removeFromParent();
    }

    position += velocity * dt;
    super.update(dt);
  }

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4, 
        stepTime: 0.12,
        textureSize: Vector2.all(16),
        ),
      );
      add(CircleHitbox(
        collisionType: CollisionType.active
      ));
  }
}
