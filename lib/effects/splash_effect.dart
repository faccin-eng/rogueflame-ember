import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class SplashEffect extends CircleComponent {
  SplashEffect({required Vector2 position})
      : super(
          position: position,
          radius: 5,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      ScaleEffect.to(
        Vector2.all(4),
        EffectController(duration: 0.3),
      ),
    );
    add(
      OpacityEffect.fadeOut(
        EffectController(duration: 0.3),
      )..onComplete = removeFromParent,
    );
  }
}