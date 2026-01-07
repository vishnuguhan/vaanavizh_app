import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:vaanavizh_app/game/vaanavizh_game.dart';
import 'package:vaanavizh_app/components/player.dart';

class PoemCollectible extends PositionComponent
    with HasGameRef<VaanavizhGame>, CollisionCallbacks {
  static const double size = 60.0;
  final String poemText;
  bool collected = false;
  late Path starPath;

  PoemCollectible({
    required Vector2 position,
    required this.poemText,
  }) : super(
          position: position,
          size: Vector2.all(size),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox(radius: size / 2));

    // Pre-create star path
    starPath = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * pi / 5) - pi / 2;
      final outerX = size / 2 + size / 2 * 0.8 * cos(angle);
      final outerY = size / 2 + size / 2 * 0.8 * sin(angle);

      if (i == 0) {
        starPath.moveTo(outerX, outerY);
      } else {
        starPath.lineTo(outerX, outerY);
      }

      final innerAngle = angle + 2 * pi / 10;
      final innerX = size / 2 + size / 2 * 0.3 * cos(innerAngle);
      final innerY = size / 2 + size / 2 * 0.3 * sin(innerAngle);
      starPath.lineTo(innerX, innerY);
    }
    starPath.close();
  }

  @override
  void render(Canvas canvas) {
    if (collected) return;

    super.render(canvas);

    // Draw collectible as a star with poem text
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.yellow.shade300,
          Colors.orange.shade600,
        ],
      ).createShader(Rect.fromCircle(
        center: (size / 2).toOffset(),
        radius: size.x / 2,
      ));

    // Draw star shape using pre-created path
    canvas.drawPath(starPath, paint);

    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: poemText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        (size.y - textPainter.height) / 2,
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Player && !collected) {
      collected = true;
      gameRef.collectPoem();
      removeFromParent();
    }
  }
}
