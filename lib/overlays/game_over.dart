import 'package:flutter/material.dart';

import '../screens/ember_quest.dart';

class GameOver extends StatelessWidget{
  final EmberQuestGame game;
  final VoidCallback onVoltarMenu;
  const GameOver({super.key, 
  required this.game,
  required this.onVoltarMenu,
  });

  @override
  Widget build(BuildContext context){
    // WidgetsBinding.instance.addPostFrameCallback((_) => onGameOver());
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 300,
          width: 400,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(
              Radius.circular(20)
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You Died',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    game.reset();
                    game.overlays.remove('GameOver');
                  }, style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                   child: const Text(
                    'Jogar de novo',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    )
                   )),
              )

            ],
          ),
        ),
      ),
    );
  }
}