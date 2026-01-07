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

    // Draw star shape
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * 3.14159 / 5) - 3.14159 / 2;
      final outerX = size.x / 2 + size.x / 2 * 0.8 * cos(angle);
      final outerY = size.y / 2 + size.y / 2 * 0.8 * sin(angle);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }

      final innerAngle = angle + 2 * 3.14159 / 10;
      final innerX = size.x / 2 + size.x / 2 * 0.3 * cos(innerAngle);
      final innerY = size.y / 2 + size.y / 2 * 0.3 * sin(innerAngle);
      path.lineTo(innerX, innerY);
    }
    path.close();

    canvas.drawPath(path, paint);

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

  double cos(double angle) => angle.abs() < 0.0001
      ? 1.0
      : angle.abs() - 3.14159 / 2 < 0.0001
          ? 0.0
          : _cosTaylor(angle);

  double sin(double angle) => cos(angle - 3.14159 / 2);

  double _cosTaylor(double x) {
    // Taylor series approximation for cos
    x = x % (2 * 3.14159);
    if (x > 3.14159) x -= 2 * 3.14159;
    if (x < -3.14159) x += 2 * 3.14159;

    double result = 1.0;
    double term = 1.0;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i - 1) * (2 * i));
      result += term;
    }
    return result;
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
