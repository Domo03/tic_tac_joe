import 'package:flutter/material.dart';
import 'package:tic_tac_joe/models/active_box_model.dart';

class CustomBoxSlash extends StatelessWidget {
  const CustomBoxSlash(
      {super.key,
      required this.width,
      required this.height,
      required this.direction});

  final double width;
  final double height;
  final Direction direction;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: TrianglePainter(direction: direction),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Direction direction;

  TrianglePainter({super.repaint, required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final path = Path();

    if (direction == Direction.backslash) {
      path.moveTo(0, 0);
      path.lineTo(width, height);
    } else if (direction == Direction.forwardslash) {
      path.moveTo(width, 0);
      path.lineTo(0, height);
    } else if (direction == Direction.horizontal) {
      path.moveTo(width / 2, 0);
      path.lineTo(width / 2, height);
    } else if (direction == Direction.vertical) {
      path.moveTo(0, height / 2);
      path.lineTo(width, height / 2);
    }

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.black;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw false;
  }
}
