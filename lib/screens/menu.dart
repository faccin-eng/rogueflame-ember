import 'package:flutter/material.dart';
import '../main.dart';
import 'ember_quest.dart';

class MainMenu extends StatelessWidget {

  final EmberQuestGame game;
  final bool mostrarBotoes;
  final ValueChanged<bool> onMostrarBotoesChanged;

  const MainMenu({super.key, 
  required this.game,
  required this.mostrarBotoes,
  required this.onMostrarBotoesChanged,
  });


  @override
  Widget build(BuildContext context) {


    return Material(
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
              colors:  [
              Color.fromARGB(230, 180, 30, 0),    
              Color.fromARGB(220, 220, 80, 0),    
              Color.fromARGB(210, 255, 140, 0),   
              Color.fromARGB(190, 255, 200, 50), 
            ]),
            borderRadius: BorderRadius.all(
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 150,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('MainMenu');
                  },
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
                title: Text("Botões na tela"),
                value: mostrarBotoes,
                onChanged: onMostrarBotoesChanged,
                ),
            ],
          ),
        ),
      ),
    );
  }
}