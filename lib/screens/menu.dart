import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:safeblock/screens/reward_view.dart';

class MenuBloco extends StatefulWidget{
  const MenuBloco({super.key});

  @override
  State<MenuBloco> createState() => _MenuBlocoState();
}

class _MenuBlocoState extends State<MenuBloco>{

  openDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) {
      return Center(
        child: Stack(
          children: [
            GameWidget(game: RewardView()),
            Positioned(right: 450, top: 80, child:
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.cancel_outlined)))
          ],
        ),
      );
    });
  }


    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hello World!'),
              ElevatedButton(onPressed: openDialog, child: Text('Click Me!'))
            ],
          ),
          
        ),
      ),
    );
  }
}