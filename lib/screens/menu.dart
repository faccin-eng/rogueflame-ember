import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:gamepads/gamepads.dart';
import 'package:rogueflame/screens/game_screen.dart';

class _MenuBackgroundGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/8.png'),
        ParallaxImageData('parallax/7.png'),
        ParallaxImageData('parallax/6.png'),
        ParallaxImageData('parallax/5.png'),
        ParallaxImageData('parallax/4.png'),
        ParallaxImageData('parallax/3.png'),
        ParallaxImageData('parallax/2.png'),
        ParallaxImageData('parallax/1.png'),
      ],
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.1, 0),
      fill: LayerFill.height,
      alignment: Alignment.bottomCenter,
    );
    camera.backdrop.add(parallax);
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool mostrarBotoes = true;
  StreamSubscription<NormalizedGamepadEvent>? _gamepadSub;

  @override
  void initState() {
    super.initState();
    _gamepadSub = Gamepads.normalizedEvents.listen(_handleGamepad);
  }

  @override
  void dispose() {
    _gamepadSub?.cancel();
    super.dispose();
  }

  void _handleGamepad(NormalizedGamepadEvent event) {
    if (event.button == GamepadButton.a && event.value > 0.5) {
      _startGame(false);
    }
  }

  void _startGame(bool botoes) {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(mostrarBotoes: botoes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _MenuBackgroundGame()),
          Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 350,
                width: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(230, 180, 30, 0),
                      Color.fromARGB(220, 220, 80, 0),
                      Color.fromARGB(210, 255, 140, 0),
                      Color.fromARGB(190, 255, 200, 50),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Rogueflame',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 150,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: () => _startGame(mostrarBotoes),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(148, 2, 62, 167),
                        ),
                        child: const Text(
                          'Jogar',
                          style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SwitchListTile(
                      title: const Text("Botões na tela"),
                      value: mostrarBotoes,
                      onChanged: (valor) {
                        setState(() {
                          mostrarBotoes = valor;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
