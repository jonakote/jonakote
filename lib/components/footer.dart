part of '../main.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 34),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.line))),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: const Row(
            children: [
              Text('© 2026 Joshua Tetteh', style: TextStyle(color: AppColors.muted, fontSize: 11)),
              Spacer(),
              FooterCredit(),
            ],
          ),
        ),
      ),
    );
  }
}

class FooterCredit extends StatelessWidget {
  const FooterCredit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Made with', style: TextStyle(color: AppColors.muted, fontSize: 11)),
        SizedBox(width: 5),
        Icon(Icons.favorite, color: AppColors.coral, size: 13),
        SizedBox(width: 9),
        Text('with', style: TextStyle(color: AppColors.muted, fontSize: 11)),
        SizedBox(width: 7),
        FlutterLogo(size: 16, style: FlutterLogoStyle.markOnly),
        SizedBox(width: 5),
        Text('Flutter', style: TextStyle(color: AppColors.mint, fontSize: 11, fontWeight: FontWeight.w700)),
        SizedBox(width: 12),
        ChatGptMark(),
        SizedBox(width: 5),
        Text('Codex', style: TextStyle(color: AppColors.mint, fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class ChatGptMark extends StatelessWidget {
  const ChatGptMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      message: 'ChatGPT icon',
      child: CustomPaint(size: Size(16, 16), painter: ChatGptMarkPainter()),
    );
  }
}

class ChatGptMarkPainter extends CustomPainter {
  const ChatGptMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final knot = Paint()
      ..color = AppColors.lime
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.35
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Six overlapping curved petals create a compact OpenAI/ChatGPT knot mark.
    for (var index = 0; index < 6; index++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(index * math.pi / 3);
      final petal = Path()
        ..moveTo(0, -1.5)
        ..cubicTo(1.5, -5.6, 5.7, -5.8, 6.5, -2.0)
        ..cubicTo(7.2, 1.2, 4.8, 4.2, 1.3, 4.7)
        ..cubicTo(-1.5, 5.1, -3.0, 3.2, -2.6, 1.2);
      canvas.drawPath(petal, knot);
      canvas.restore();
    }
    canvas.drawCircle(center, 1.5, Paint()..color = AppColors.lime);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
