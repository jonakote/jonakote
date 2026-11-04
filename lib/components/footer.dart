part of '../main.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final gutter = AppMetrics.gutter(compact);

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: ContentShell(
        padding: EdgeInsets.fromLTRB(gutter, 26, gutter, 36),
        child: compact
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FooterCredit(),
                  SizedBox(height: 16),
                  FooterCopyright(),
                ],
              )
            : const Row(
                children: [
                  FooterCopyright(),
                  Spacer(),
                  FooterCredit(),
                ],
              ),
      ),
    );
  }
}

class FooterCopyright extends StatelessWidget {
  const FooterCopyright({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '© 2026 Joshua Tetteh',
      style: TextStyle(color: AppColors.mutedSoft, fontSize: 11),
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
        Text(
          'Made with',
          style: TextStyle(color: AppColors.mutedSoft, fontSize: 11),
        ),
        SizedBox(width: 6),
        HeartBeat(),
        SizedBox(width: 10),
        Text(
          'with',
          style: TextStyle(color: AppColors.mutedSoft, fontSize: 11),
        ),
        SizedBox(width: 7),
        FlutterLogo(size: 16, style: FlutterLogoStyle.markOnly),
        SizedBox(width: 5),
        Text(
          'Flutter',
          style: TextStyle(
            color: AppColors.mint,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 9),
        Text(
          '&',
          style: TextStyle(
            color: AppColors.mutedSoft,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 9),
        ChatGptMark(),
        SizedBox(width: 5),
        Text(
          'Codex',
          style: TextStyle(
            color: AppColors.mint,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// The footer heart, with an actual heartbeat.
class HeartBeat extends StatefulWidget {
  const HeartBeat({super.key});

  @override
  State<HeartBeat> createState() => _HeartBeatState();
}

class _HeartBeatState extends State<HeartBeat>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.favorite, color: AppColors.coral, size: 13);
    if (prefersReducedMotion(context)) return icon;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // Two quick beats, then rest — closer to a real pulse than a sine.
        final t = _controller.value;
        final beat = t < 0.12
            ? Curves.easeOut.transform(t / 0.12)
            : t < 0.24
                ? 1 - Curves.easeIn.transform((t - 0.12) / 0.12)
                : t < 0.34
                    ? Curves.easeOut.transform((t - 0.24) / 0.1) * 0.6
                    : t < 0.46
                        ? (1 - Curves.easeIn.transform((t - 0.34) / 0.12)) * 0.6
                        : 0.0;
        return Transform.scale(scale: 1 + beat * 0.22, child: icon);
      },
    );
  }
}

class ChatGptMark extends StatelessWidget {
  const ChatGptMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      message: 'ChatGPT icon',
      child: Image(
        image: AssetImage('assets/brand/chatgpt.png'),
        width: 16,
        height: 16,
        fit: BoxFit.contain,
        color: AppColors.mint,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}
