import 'package:flutter/material.dart';

import 'ember_quest.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final EmberQuestGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {


    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 400,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ember Quest',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('MainMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
'''Use as setas para mover ou pular.
Desvie dos inimigos e pegue as estrelas.''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}