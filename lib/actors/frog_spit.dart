import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:rogueflame/objects/platform_block.dart';
import 'package:rogueflame/objects/ground_block.dart';
import 'package:rogueflame/actors/ember.dart';
import '../screens/ember_quest.dart';

class FrogSpit extends SpriteComponent with CollisionCallbacks, HasGameReference<EmberQuestGame> {
  final Vector2 velocity = Vector2.zero();
  final int direction; // 1 for right, -1 for left
  final double speed = 300.0;

  FrogSpit({
    required Vector2 position,
    required this.direction,
  }) : super(size: Vector2.all(24), anchor: Anchor.center) {
    this.position = position;
  }

  @override
  Future<void> onLoad() async {
    // Use star.png for now, tinted green
    final starImage = game.images.fromCache('star.png');
    sprite = Sprite(starImage);
    // Tint (if we want) - maybe later with paint
    add(CircleHitbox()..collisionType = CollisionType.active);
    velocity.x = direction * speed;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlatformBlock || other is GroundBlock) {
      removeFromParent();
      return;
    }
    if (other is EmberPlayer) {
      game.ember?.hit();
      removeFromParent();
      return;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    velocity.x = direction * speed + game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x || position.x > game.size.x + size.x) {
      removeFromParent();
    }
    super.update(dt);
  }
}
