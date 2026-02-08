
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class RewardView extends FlameGame{
  @override
  Color backgroundColor() => Colors.transparent;
  @override
  void onMount() {
    spawnComponents();
    super.onMount();
  }

  void spawnComponents(){
    add(CircleComponent(
      radius: 100,
      position: Vector2(500, 80),
    ));
  }

}