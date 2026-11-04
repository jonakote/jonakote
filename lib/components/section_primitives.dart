part of '../main.dart';

/// Availability badge with a breathing dot.
class StatusTag extends StatelessWidget {
  const StatusTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 14, 7),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.line),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PulseDot(),
          SizedBox(width: 6),
          Text(
            'INDEPENDENTLY BUILT ON THE WEB',
            style: TextStyle(
              color: AppColors.mint,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Scroll hint with a light that travels down the rule.
class ScrollCue extends StatefulWidget {
  const ScrollCue({super.key});

  @override
  State<ScrollCue> createState() => _ScrollCueState();
}

class _ScrollCueState extends State<ScrollCue>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const railHeight = 46.0;
    final still = prefersReducedMotion(context);

    return Row(
      children: [
        SizedBox(
          width: 1,
          height: railHeight,
          child: Stack(
            children: [
              const Positioned.fill(child: ColoredBox(color: AppColors.line)),
              if (!still)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = Curves.easeInOut.transform(_controller.value);
                    return Positioned(
                      top: t * (railHeight - 14),
                      child: Container(
                        width: 1,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.lime,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lime.withValues(alpha: 0.7),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        const Text(
          'Scroll to explore',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 11,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}

/// One of the three operating principles. Hover raises the rule and the title.
class Principle extends StatelessWidget {
  const Principle({
    required this.number,
    required this.title,
    required this.copy,
    super.key,
  });

  final String number;
  final String title;
  final String copy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: HoverBuilder(
        cursor: SystemMouseCursors.basic,
        builder: (context, hovered) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: AppMotion.base,
              curve: AppMotion.emphasized,
              height: 2,
              width: hovered ? 56 : 22,
              decoration: BoxDecoration(
                gradient: AppColors.accentSweep,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              number,
              style: const TextStyle(
                color: AppColors.lime,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 12),
            AnimatedDefaultTextStyle(
              duration: AppMotion.base,
              style: TextStyle(
                fontFamily: AppType.body,
                fontSize: 16.5,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
                color: hovered ? AppColors.lime : Colors.white,
              ),
              child: Text(title),
            ),
            const SizedBox(height: 9),
            Text(
              copy,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 12.5,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Centres a max-width column on the page.
///
/// The explicit `width: double.infinity` matters: without it the inner Column
/// shrink-wraps to its widest child, so a section with only narrow content
/// (the contact block, for instance) drifts to the middle of the page instead
/// of lining up with every other section's left edge.
class ContentShell extends StatelessWidget {
  const ContentShell({required this.padding, required this.child, super.key});

  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppMetrics.maxContentWidth,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Standard section frame: eyebrow, display title, content — all revealed in
/// sequence as the section enters the viewport.
class SectionShell extends StatelessWidget {
  const SectionShell({
    required this.compact,
    required this.eyebrow,
    required this.title,
    required this.child,
    super.key,
  });

  final bool compact;
  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gutter = AppMetrics.gutter(compact);
    final vertical = compact ? 84.0 : 120.0;

    return ContentShell(
      padding: EdgeInsets.fromLTRB(gutter, vertical, gutter, vertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(child: SectionEyebrow(label: eyebrow)),
          const SizedBox(height: 22),
          Reveal(
            delay: const Duration(milliseconds: 80),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: AppType.display,
                fontSize: AppType.fluid(context, min: 34, max: 56),
                height: 1.04,
                letterSpacing: compact ? -1.4 : -2.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: compact ? 40 : 52),
          Reveal(
            delay: const Duration(milliseconds: 150),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Small all-caps label with a leading rule, used above every section title.
class SectionEyebrow extends StatelessWidget {
  const SectionEyebrow({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 1,
          color: AppColors.mint.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.mint,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
          ),
        ),
      ],
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({required this.label, required this.accent, super.key});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.basic,
      builder: (context, hovered) => AnimatedContainer(
        duration: AppMotion.fast,
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: hovered ? 0.18 : 0.08),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: accent.withValues(alpha: hovered ? 0.5 : 0.16),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
