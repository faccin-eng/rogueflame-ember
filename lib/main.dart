import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safeblock/overlays/game_over.dart';
import 'package:safeblock/screens/ember_quest.dart';
import 'package:safeblock/screens/menu.dart';
import 'utils/game_controls.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late final EmberQuestGame _game;
  bool mostrarBotoes = true;
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
        GameWidget(
          game: _game,
          overlayBuilderMap: {
            'MainMenu': (_, game) => MainMenu(
              game: game as EmberQuestGame,
            mostrarBotoes: mostrarBotoes,
            onMostrarBotoesChanged: (valor){
              setState(() {
                mostrarBotoes = valor;
              });
            }),
            'GameOver': (_, game) => GameOver(game: game as EmberQuestGame),
          },
          initialActiveOverlays: const ['MainMenu'],
          ),
        if (mostrarBotoes) 
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

