import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rogueflame/overlays/game_over.dart';
import 'package:rogueflame/screens/ember_quest.dart';
import 'package:rogueflame/screens/menu.dart';
import 'package:rogueflame/utils/gest_controls.dart';
import 'utils/game_controls.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: MainMenu(),
    );
  }
}
/*
class _MyAppState extends State<MyApp>{
  late final EmberQuestGame _game;
  bool mostrarBotoes = true;
  bool gameStart = false;
  @override
  void initState(){
    super.initState();
    _game = EmberQuestGame();
  }
@override
Widget build(BuildContext context) {
  // Verifica se algum overlay está ativo
  final temOverlay = _game.overlays.isActive('MainMenu') || 
                     _game.overlays.isActive('GameOver');
  final controlesAtivos = gameStart && !temOverlay;

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
                onMostrarBotoesChanged: (valor) {
                  setState(() {
                    mostrarBotoes = valor;
                  });
                },
                onJogar: () {
                  setState(() {
                    gameStart = true;
                  });
                },
              ),
              'GameOver': (_, game) => GameOver(
                game: game as EmberQuestGame,
                onGameOver: () {
                  setState(() {
                    gameStart = false;
                  });
                },
              ),
            },
            initialActiveOverlays: const ['MainMenu'],
          ),
          // Controles ficam ABAIXO dos overlays no Stack
          // IgnorePointer desativa os toques quando não é pra funcionar
          if (mostrarBotoes)
            IgnorePointer(
              ignoring: !controlesAtivos,
              child: GameControls(
                onLeftPressed: () => _game.ember?.moveLeft(),
                onLeftReleased: () => _game.ember?.stopMoving(),
                onRightPressed: () => _game.ember?.moveRight(),
                onRightReleased: () => _game.ember?.stopMoving(),
                onJump: () => _game.ember?.jump(),
              ),
            ),
          if (!mostrarBotoes)
            IgnorePointer(
              ignoring: !controlesAtivos,
              child: GestControls(
                onLeftPressed: () => _game.ember?.moveLeft(),
                onLeftReleased: () => _game.ember?.stopMoving(),
                onRightPressed: () => _game.ember?.moveRight(),
                onRightReleased: () => _game.ember?.stopMoving(),
                onJump: () => _game.ember?.jump(),
              ),
            ),
        ],
      ),
    ),
  );
}
}
*/