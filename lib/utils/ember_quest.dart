import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:safeblock/actors/ember.dart';

class EmberQuestGame extends FlameGame {

  late EmberPlayer _ember;

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

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 120),
    );
    world.add(_ember);
  }
}