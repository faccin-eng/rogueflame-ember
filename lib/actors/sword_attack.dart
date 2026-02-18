import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../actors/water_enemy.dart';

class SwordAttack extends SpriteAnimationComponent with CollisionCallbacks{
  SwordAttack({
    required super.animation,
    required super.size,
    required super.anchor,
    required super.position,
  }) : super(removeOnFinish: true);

  @override
  void onLoad(){
    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other){
    if (other is WaterEnemy){
      other.takeHit();
    }
    super.onCollision(intersectionPoints, other);
  }
}