import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:vaanavizh_app/game/vaanavizh_game.dart';

void main() {
  runApp(const VaanavizhApp());
}

class VaanavizhApp extends StatelessWidget {
  const VaanavizhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VaanAvizh Poems',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: GameWidget(
          game: VaanavizhGame(),
        ),
      ),
    );
  }
}
