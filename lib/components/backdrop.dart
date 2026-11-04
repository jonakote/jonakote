part of '../main.dart';

/// Full-page atmospheric layer: two slow-drifting accent glows, a faint
/// technical grid, and a vignette. It sits behind the scroll view and never
/// receives pointer events.
class AuroraBackdrop extends StatefulWidget {
  const AuroraBackdrop({super.key});

  @override
  State<AuroraBackdrop> createState() => _AuroraBackdropState();
}

class _AuroraBackdropState extends State<AuroraBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 26),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final still = prefersReducedMotion(context);

    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: AppColors.ink),
          if (still)
            const _AuroraGlows(t: 0.25)
          else
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => _AuroraGlows(t: _controller.value),
            ),
          const Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          // Vignette: keeps the edges calm so text stays the loudest thing.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.4,
                  colors: [
                    Colors.transparent,
                    AppColors.ink.withValues(alpha: 0.72),
                  ],
                  stops: const [0.45, 1],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuroraGlows extends StatelessWidget {
  const _AuroraGlows({required this.t});

  /// 0..1 loop position.
  final double t;

  @override
  Widget build(BuildContext context) {
    // Two offset sine paths so the glows never line up in the same spot.
    final a = math.sin(t * 2 * math.pi);
    final b = math.sin((t * 2 * math.pi) + math.pi / 2);

    return Stack(
      fit: StackFit.expand,
      children: [
        _Glow(
          alignment: Alignment(-0.65 + a * 0.18, -0.85 + b * 0.08),
          color: AppColors.lime,
          opacity: 0.1,
          diameter: 760,
        ),
        _Glow(
          alignment: Alignment(0.8 + b * 0.14, -0.35 + a * 0.12),
          color: AppColors.mint,
          opacity: 0.075,
          diameter: 620,
        ),
        _Glow(
          alignment: Alignment(0.15 - a * 0.2, 0.75 + b * 0.1),
          color: AppColors.violet,
          opacity: 0.055,
          diameter: 680,
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({
    required this.alignment,
    required this.color,
    required this.opacity,
    required this.diameter,
  });

  final Alignment alignment;
  final Color color;
  final double opacity;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

/// Faint 72px grid — reads as drafting paper rather than decoration.
class _GridPainter extends CustomPainter {
  const _GridPainter();

  static const _cell = 72.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.line.withValues(alpha: 0.38)
      ..strokeWidth = 1;

    for (var x = 0.0; x <= size.width; x += _cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += _cell) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}

/// A soft light that tracks the pointer. Only mounted on the hero, only when
/// a precise pointer is present, and skipped entirely under reduced motion.
class PointerSpotlight extends StatefulWidget {
  const PointerSpotlight({required this.child, super.key});

  final Widget child;

  @override
  State<PointerSpotlight> createState() => _PointerSpotlightState();
}

class _PointerSpotlightState extends State<PointerSpotlight> {
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    if (prefersReducedMotion(context)) return widget.child;

    return MouseRegion(
      opaque: false,
      onHover: (event) => setState(() => _position = event.localPosition),
      onExit: (_) => setState(() => _position = null),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _position == null ? 0 : 1,
                duration: AppMotion.base,
                child: CustomPaint(
                  painter: _SpotlightPainter(_position ?? Offset.zero),
                ),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  const _SpotlightPainter(this.center);

  final Offset center;

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 280.0;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.lime.withValues(alpha: 0.08),
          AppColors.lime.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_SpotlightPainter oldDelegate) =>
      oldDelegate.center != center;
}
