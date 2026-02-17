import 'package:flutter/material.dart';
import 'package:rogueflame/screens/game_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
  }

  class _MainMenuState extends State<MainMenu>{
  bool mostrarBotoes = true;


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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameScreen(mostrarBotoes: mostrarBotoes),
                        ),
                      );

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
    );
  }
}