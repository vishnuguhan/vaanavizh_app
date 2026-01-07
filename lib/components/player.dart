import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent {
  static const double speed = 200.0;
  static const double size = 40.0;

  Vector2? targetPosition;
  late Paint gradientPaint;
  late Paint eyePaint;
  late Paint pupilPaint;
  late Paint smilePaint;

  Player({required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(size),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Pre-create paint objects
    eyePaint = Paint()..color = Colors.white;
    pupilPaint = Paint()..color = Colors.black;
    smilePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw player as a circle with a gradient
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.blue.shade300,
          Colors.blue.shade700,
        ],
      ).createShader(Rect.fromCircle(
        center: (size / 2).toOffset(),
        radius: size.x / 2,
      ));

    canvas.drawCircle(
      (size / 2).toOffset(),
      size.x / 2,
      paint,
    );

    // Draw eyes
    canvas.drawCircle(
      Offset(size.x * 0.35, size.y * 0.35),
      4,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(size.x * 0.65, size.y * 0.35),
      4,
      eyePaint,
    );

    // Draw pupils
    canvas.drawCircle(
      Offset(size.x * 0.35, size.y * 0.35),
      2,
      pupilPaint,
    );
    canvas.drawCircle(
      Offset(size.x * 0.65, size.y * 0.35),
      2,
      pupilPaint,
    );

    // Draw smile
    canvas.drawArc(
      Rect.fromLTWH(
        size.x * 0.25,
        size.y * 0.5,
        size.x * 0.5,
        size.y * 0.3,
      ),
      0,
      3.14,
      false,
      smilePaint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (targetPosition != null) {
      final direction = targetPosition! - position;
      final distance = direction.length;

      if (distance > speed * dt) {
        direction.normalize();
        position += direction * speed * dt;
      } else {
        position = targetPosition!;
        targetPosition = null;
      }
    }
  }

  void moveTo(Vector2 target) {
    targetPosition = target;
  }
}
