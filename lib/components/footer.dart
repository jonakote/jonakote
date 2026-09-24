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
        CodexMark(),
        SizedBox(width: 5),
        Text('Codex', style: TextStyle(color: AppColors.mint, fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class CodexMark extends StatelessWidget {
  const CodexMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(size: Size(16, 16), painter: CodexMarkPainter());
  }
}

class CodexMarkPainter extends CustomPainter {
  const CodexMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final ray = Paint()
      ..color = AppColors.lime
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    for (final direction in const [Offset(0, -1), Offset(1, 0), Offset(0, 1), Offset(-1, 0)]) {
      canvas.drawLine(center + direction * 2.5, center + direction * 7, ray);
    }
    canvas.drawCircle(center, 2.5, Paint()..color = AppColors.lime);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
