import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:rogueflame/overlays/game_over.dart';
import 'package:rogueflame/screens/ember_quest.dart';
import 'package:rogueflame/utils/gest_controls.dart';
import 'package:rogueflame/utils/game_controls.dart';
import 'package:rogueflame/utils/gamepad_controls.dart';

class GameScreen extends StatefulWidget {
  final bool mostrarBotoes;

  const GameScreen({super.key, required this.mostrarBotoes});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>{
  late final EmberQuestGame _game;
  late final GamepadControls _gamepad;
  bool gameOver = false;
  VoidCallback? onGameOver;

  @override
  void initState(){
    super.initState();
    _game = EmberQuestGame();
    _game.onGameOver = () {
      setState(() {
        gameOver = true;
      });
    };
    _gamepad = GamepadControls(
      onLeftPressed:   () => _game.ember?.moveLeft(),
      onLeftReleased:  () => _game.ember?.stopMoving(),
      onRightPressed:  () => _game.ember?.moveRight(),
      onRightReleased: () => _game.ember?.stopMoving(),
      onJump:          () => _game.ember?.jump(),
      onAttack:        () => _game.ember?.attack(),
    );
    _gamepad.attach();
  }

  @override
  void dispose() {
    _gamepad.dispose();
    _game.onGameOver = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: _game,
            overlayBuilderMap: {
              'GameOver': (_, game) => GameOver(
                game: game as EmberQuestGame,
                onVoltarMenu: (){
                  setState(() {
                    gameOver = false;
                  });
                },
              ),
            },
          ),
          if (!gameOver && widget.mostrarBotoes)
          GameControls(
              onLeftPressed: () => _game.ember?.moveLeft(),
              onLeftReleased: () => _game.ember?.stopMoving(),
              onRightPressed: () => _game.ember?.moveRight(),
              onRightReleased: () => _game.ember?.stopMoving(),
              onJump: () => _game.ember?.jump(),
              onAttack: () => _game.ember?.attack(),
            ),
          if (!gameOver && !widget.mostrarBotoes)
            GestControls(
              onLeftPressed: () => _game.ember?.moveLeft(),
              onLeftReleased: () => _game.ember?.stopMoving(),
              onRightPressed: () => _game.ember?.moveRight(),
              onRightReleased: () => _game.ember?.stopMoving(),
              onJump: () => _game.ember?.jump(),
            ),
        ],
      )
    );
  }
}

