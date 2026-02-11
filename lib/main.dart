import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:safeblock/screens/ember_quest.dart';
import 'utils/game_controls.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late final EmberQuestGame _game;
  @override
  void initState(){
    super.initState();
    _game = EmberQuestGame();
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Stack(
      children: [
        IgnorePointer(
          child: GameWidget(game: _game),
            ),
        
        GameControls(
          onLeftPressed: () => _game.ember?.moveLeft(),
          onLeftReleased: () => _game.ember?.stopMoving(),
          onRightPressed: () => _game.ember?.moveRight(),
          onRightReleased: () => _game.ember?.stopMoving(),
          onJump: () => _game.ember?.jump(),
        ),
      ],
    ),
  ),
    );
  }   
}

