import 'package:flutter/material.dart';

class RoundSquareImage extends StatelessWidget {
  const RoundSquareImage({
    super.key,
    required this.size,
    required this.image,
  });

  final double size;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(
        painter: RoundSquarePainter(context: context),
        child: ClipPath(
          clipper: RoundSquareClipper(),
          child: image,
        ),
      ),
    );
  }
}

Path roundSquarePath(Size size) {
  Path path = Path();

  double w = size.width, h = size.height;

  path.moveTo(w / 2, 0);

  path.cubicTo(w * 0.1, 0, 0, h * 0.1, 0, h / 2);
  path.cubicTo(0, h * 0.9, w * 0.1, h, w / 2, h);
  path.cubicTo(w * 0.9, h, w, h * 0.9, w, h / 2);
  path.cubicTo(w, h * 0.1, w * 0.9, 0, w / 2, 0);

  path.close();
  return path;
}

class RoundSquarePainter extends CustomPainter {
  const RoundSquarePainter({required this.context});
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Theme.of(context).scaffoldBackgroundColor;
    Path path = roundSquarePath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RoundSquareClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return roundSquarePath(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}