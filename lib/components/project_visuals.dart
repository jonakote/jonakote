part of '../main.dart';

class OrbitVisual extends StatelessWidget {
  const OrbitVisual({super.key});

  @override
  Widget build(BuildContext context) => CustomPaint(painter: OrbitPainter());
}

class OrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * .53, size.height * .48);
    final stroke = Paint()..style = PaintingStyle.stroke..strokeWidth = 1..color = AppColors.line;
    for (final scale in [1.0, .72, .43]) {
      canvas.drawOval(Rect.fromCenter(center: center, width: size.width * scale, height: size.height * scale * .7), stroke);
    }
    final dot = Paint()..color = AppColors.lime;
    canvas.drawCircle(Offset(center.dx + size.width * .25, center.dy - 35), 7, dot);
    canvas.drawCircle(Offset(center.dx - size.width * .28, center.dy + 20), 4, Paint()..color = AppColors.mint);
    canvas.drawCircle(center, 13, Paint()..color = AppColors.lime);
    final textPainter = TextPainter(
      text: const TextSpan(text: '01', style: TextStyle(color: AppColors.ink, fontSize: 10, fontWeight: FontWeight.w900)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SignalVisual extends StatelessWidget {
  const SignalVisual({super.key});

  @override
  Widget build(BuildContext context) => CustomPaint(painter: SignalPainter());
}

class SignalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()..color = AppColors.line..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 26) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (var y = 0.0; y < size.height; y += 26) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
    final wave = Paint()..color = AppColors.coral..strokeWidth = 2.2..style = PaintingStyle.stroke;
    final path = Path()..moveTo(0, size.height * .62);
    for (var x = 0.0; x <= size.width; x += 4) {
      final y = size.height * .5 + (size.height * .18 * (x / size.width)) * (x.isNaN ? 0 : 1) * (x % 58 < 29 ? -1 : 1);
      path.lineTo(x, y);
    }
    canvas.drawPath(path, wave);
    canvas.drawCircle(Offset(size.width * .72, size.height * .32), 7, Paint()..color = AppColors.coral);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
