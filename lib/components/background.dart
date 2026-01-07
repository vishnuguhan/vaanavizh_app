import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:vaanavizh_app/game/vaanavizh_game.dart';

class GameBackground extends Component with HasGameRef<VaanavizhGame> {
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Create a gradient background
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF1a1a2e),
          const Color(0xFF16213e),
          const Color(0xFF0f3460),
        ],
      ).createShader(Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y),
      paint,
    );

    // Draw stars in the background
    final starPaint = Paint()..color = Colors.white.withOpacity(0.6);

    for (int i = 0; i < 50; i++) {
      final x = (i * 137.5) % gameRef.size.x;
      final y = (i * 97.3) % gameRef.size.y;
      final radius = (i % 3) + 1.0;
      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }

    // Draw title
    final titlePainter = TextPainter(
      text: const TextSpan(
        text: 'VaanAvizh Poems',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout();
    titlePainter.paint(
      canvas,
      Offset(
        (gameRef.size.x - titlePainter.width) / 2,
        20,
      ),
    );

    // Draw instructions
    final instructionPainter = TextPainter(
      text: const TextSpan(
        text: 'Tap anywhere to move and collect Tamil poems!',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    instructionPainter.layout();
    instructionPainter.paint(
      canvas,
      Offset(
        (gameRef.size.x - instructionPainter.width) / 2,
        60,
      ),
    );

    // Draw score
    final scorePainter = TextPainter(
      text: TextSpan(
        text:
            'Poems Collected: ${gameRef.poemsCollected}/${gameRef.totalPoems}',
        style: const TextStyle(
          color: Colors.yellowAccent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    scorePainter.layout();
    scorePainter.paint(
      canvas,
      Offset(
        (gameRef.size.x - scorePainter.width) / 2,
        gameRef.size.y - 40,
      ),
    );
  }
}
