import 'package:flutter/material.dart';

import '../screens/ember_quest.dart';

class GameOver extends StatelessWidget{
  final EmberQuestGame game;
  const GameOver({super.key, required this.game});

  @override
  Widget build(BuildContext context){
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 200,
          width: 300,
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
                  color: Colors.white,
                  fontSize: 24
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
                    'Jogar Novamente',
                    style: TextStyle(
                      fontSize: 28.0,
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