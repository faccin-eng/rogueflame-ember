import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:safeblock/objects/platform_block.dart';
import '../screens/ember_quest.dart';

class WaterEnemy extends SpriteAnimationComponent with CollisionCallbacks, HasGameReference<EmberQuestGame>{
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  WaterEnemy({
    required this.gridPosition,
    required this.xOffset,    
  }) : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2, 
        stepTime: 0.70,
        textureSize: Vector2.all(16),
      ),
    );
        position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(RectangleHitbox(collisionType: CollisionType.active));
    add(
      MoveEffect.by(
        Vector2(-2 * size.x, 0),
        EffectController(
          duration: 3,
          alternate: true,
          infinite: true,
        ),
      ),
    );
  }

  
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
    if (other is PlatformBlock){
      if (intersectionPoints.length == 2){
        final mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1))/2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        position += collisionNormal.scaled(separationDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt){
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x) removeFromParent();
    //instead of removing the enemy I'm making them speed up to the sky (it should be just a fast pace)
    if (game.health <= 0) {
          add(
      MoveEffect.to(
        Vector2(-2 * size.x, 0),
        EffectController(
          duration: 3,
          alternate: true,
          infinite: true,
        ),
        ),
      );
    }
    super.update(dt);
  }

}