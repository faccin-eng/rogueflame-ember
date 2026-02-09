import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:safeblock/screens/menu.dart';
import 'package:safeblock/utils/ember_quest.dart';

void main() {
  runApp(
    const GameWidget<EmberQuestGame>.controlled(
      gameFactory: EmberQuestGame.new,
      ),
    );
}



/*
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build (BuildContext context){
  return MaterialApp(
    home: MenuBloco(),
  );}


}
*/