import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:vaanavizh_app/components/player.dart';
import 'package:vaanavizh_app/components/poem_collectible.dart';
import 'package:vaanavizh_app/components/background.dart';

class VaanavizhGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  late Player player;
  int poemsCollected = 0;
  int totalPoems = 5;

  @override
  Color backgroundColor() => const Color(0xFF2C1810);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add background
    add(GameBackground());

    // Add player
    player = Player(position: size / 2);
    add(player);

    // Add poem collectibles
    _spawnPoems();
  }

  void _spawnPoems() {
    final poems = [
      'வானம்',
      'அவிழ்',
      'கவிதை',
      'இசை',
      'நிலவு',
    ];

    for (int i = 0; i < totalPoems; i++) {
      final x = (i + 1) * size.x / (totalPoems + 1);
      final y = 100 + (i % 3) * 150.0;
      add(PoemCollectible(
        position: Vector2(x, y),
        poemText: poems[i],
      ));
    }
  }

  void collectPoem() {
    poemsCollected++;
    if (poemsCollected >= totalPoems) {
      _showVictory();
    }
  }

  void _showVictory() {
    // Victory state can be handled here
    overlays.add('victory');
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    player.moveTo(info.eventPosition.global);
  }
}
