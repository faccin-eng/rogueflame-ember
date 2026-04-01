import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:rogueflame/actors/ember.dart';
import 'package:rogueflame/screens/ember_quest.dart';

class HeartPickup extends SpriteComponent
    with CollisionCallbacks, HasGameReference<EmberQuestGame> {
  final Vector2 velocity = Vector2.zero();

  HeartPickup({
    required super.position,
  }) : super(
          size: Vector2.all(28),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await game.loadSprite(
      'heart.png',
      srcSize: Vector2.all(24),
    );

    add(CircleHitbox(collisionType: CollisionType.passive));
    add(
      MoveEffect.by(
        Vector2(0, -6),
        EffectController(
          duration: 0.5,
          reverseDuration: 0.5,
          infinite: true,
        ),
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EmberPlayer && game.health < game.maxHealth) {
      game.health = (game.health + 1).clamp(0, game.maxHealth);
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;

    if (position.x < -size.x) {
      removeFromParent();
    }

    super.update(dt);
  }
}
