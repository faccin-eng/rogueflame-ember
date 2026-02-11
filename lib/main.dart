import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:safeblock/screens/menu.dart';
import 'package:safeblock/screens/ember_quest.dart';

void main() {
  runApp(
    const GameWidget<EmberQuestGame>.controlled(
      gameFactory: EmberQuestGame.new,
      ),
    );
}

