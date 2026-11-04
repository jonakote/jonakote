part of '../main.dart';

/// Opening screen. Everything animates in on load (staggered), the headline
/// carries a gradient accent, and a pointer-tracked light sits behind it.
class HeroSection extends StatefulWidget {
  const HeroSection({
    required this.compact,
    required this.onExplore,
    required this.onContact,
    super.key,
  });

  final bool compact;
  final VoidCallback onExplore;
  final VoidCallback onContact;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  );

  @override
  void initState() {
    super.initState();
    _intro.forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  /// Staggered slice of the intro timeline.
  Widget _step(int index, Widget child, {double offset = 22}) {
    if (prefersReducedMotion(context)) return child;
    final start = (index * 0.1).clamp(0.0, 0.7);
    final animation = CurvedAnimation(
      parent: _intro,
      curve: Interval(start, (start + 0.45).clamp(0.0, 1.0),
          curve: AppMotion.emphasized),
    );
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) => Opacity(
        opacity: animation.value,
        child: Transform.translate(
          offset: Offset(0, (1 - animation.value) * offset),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact = widget.compact;
    final gutter = AppMetrics.gutter(compact);

    return PointerSpotlight(
      child: ContentShell(
        padding: EdgeInsets.fromLTRB(
          gutter,
          compact ? 72 : 118,
          gutter,
          compact ? 76 : 104,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _step(0, const StatusTag()),
            SizedBox(height: compact ? 26 : 32),
            _step(1, const HeroHeadline(), offset: 30),
            SizedBox(height: compact ? 26 : 34),
            _step(
              2,
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 530),
                child: const Text(
                  'I’m Joshua Tetteh — a builder interested in the space '
                  'where useful products, clear interfaces, and thoughtful '
                  'code meet.',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 17.5,
                    height: 1.7,
                  ),
                ),
              ),
            ),
            SizedBox(height: compact ? 32 : 40),
            _step(
              3,
              Wrap(
                spacing: 14,
                runSpacing: 14,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  PillButton(
                    label: 'Explore the work',
                    trailing: '↓',
                    onPressed: widget.onExplore,
                  ),
                  PillButton(
                    label: 'Start a conversation',
                    filled: false,
                    onPressed: widget.onContact,
                  ),
                ],
              ),
            ),
            SizedBox(height: compact ? 56 : 76),
            _step(4, const HeroToolkitStrip()),
            SizedBox(height: compact ? 48 : 64),
            _step(5, const ScrollCue()),
          ],
        ),
      ),
    );
  }
}

/// The display headline, with a gradient on the accent word.
class HeroHeadline extends StatelessWidget {
  const HeroHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppType.fluid(context, min: 46, max: 92);
    final base = TextStyle(
      color: Colors.white,
      fontFamily: AppType.display,
      fontSize: size,
      height: 0.98,
      letterSpacing: size * -0.055,
      fontWeight: FontWeight.w700,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Digital things', style: base),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('with ', style: base),
            // Gradient fill on the accent word rather than a flat lime.
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.accentSweep.createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: Text('intent.', style: base),
            ),
          ],
        ),
      ],
    );
  }
}

/// Slow ticker of the actual toolkit — the one continuously moving element.
class HeroToolkitStrip extends StatelessWidget {
  const HeroToolkitStrip({super.key});

  static const _items = <String>[
    'Flutter',
    'Dart',
    'Flutter Web',
    'Go',
    'Django',
    'Docker',
    'Nginx',
    'OpenTelemetry',
    'Product thinking',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TOOLKIT',
          style: TextStyle(
            color: AppColors.mutedSoft,
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 20,
          child: Marquee(
            speed: 22,
            spacing: 30,
            children: [
              for (final item in _items)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.lime.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
