part of '../main.dart';

/// Exposes the page's [ScrollController] to descendants so scroll-driven
/// effects (reveals, nav state, progress) don't need callbacks threaded
/// through every section.
class PortfolioScroll extends InheritedWidget {
  const PortfolioScroll({
    required this.controller,
    required super.child,
    super.key,
  });

  final ScrollController controller;

  static ScrollController? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PortfolioScroll>()?.controller;

  @override
  bool updateShouldNotify(PortfolioScroll oldWidget) =>
      oldWidget.controller != controller;
}

/// True when the user has asked the platform to reduce motion. Every animated
/// widget here honours it and renders its resting state instead.
bool prefersReducedMotion(BuildContext context) =>
    MediaQuery.maybeOf(context)?.disableAnimations ?? false;

/// Fades and lifts its child into place the first time it scrolls into view.
/// Plays once — revisiting a section does not replay it.
class Reveal extends StatefulWidget {
  const Reveal({
    required this.child,
    this.delay = Duration.zero,
    this.offset = 26,
    this.duration = AppMotion.reveal,
    super.key,
  });

  final Widget child;
  final Duration delay;
  final double offset;
  final Duration duration;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: AppMotion.emphasized,
  );

  ScrollController? _scroll;
  bool _revealed = false;
  bool _checkScheduled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final next = PortfolioScroll.maybeOf(context);
    if (next != _scroll) {
      _scroll?.removeListener(_scheduleCheck);
      _scroll = next;
      _scroll?.addListener(_scheduleCheck);
    }
    _scheduleCheck();
  }

  /// Scroll notifications fire *before* the new layout is applied, so reading
  /// our position straight from the listener can be a frame stale — enough to
  /// miss the reveal entirely when a scroll comes to rest. Defer the check to
  /// the end of the frame, and keep re-checking each frame until we've either
  /// revealed or the frames stop coming.
  void _scheduleCheck() {
    if (_revealed || _checkScheduled || !mounted) return;
    _checkScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      _maybeReveal();
    });
  }

  void _maybeReveal() {
    if (_revealed || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      _scheduleCheck();
      return;
    }

    final top = box.localToGlobal(Offset.zero).dy;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    // Trigger a little before the element is fully on screen.
    if (top > viewportHeight * 0.94) return;

    _revealed = true;
    _scroll?.removeListener(_scheduleCheck);

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future<void>.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _scroll?.removeListener(_scheduleCheck);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (prefersReducedMotion(context)) return widget.child;

    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        final t = _animation.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * widget.offset),
            child: child,
          ),
        );
      },
    );
  }
}

/// Reveals a list of children one after another with a fixed stagger.
class RevealGroup extends StatelessWidget {
  const RevealGroup({
    required this.children,
    this.stagger = const Duration(milliseconds: 90),
    this.offset = 26,
    super.key,
  });

  final List<Widget> children;
  final Duration stagger;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++)
          Reveal(
            delay: stagger * i,
            offset: offset,
            child: children[i],
          ),
      ],
    );
  }
}

/// Minimal hover/focus plumbing: gives the builder a bool and handles the
/// cursor, so interactive widgets stay declarative.
class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    required this.builder,
    this.cursor = SystemMouseCursors.click,
    this.onTap,
    this.semanticLabel,
    super.key,
  });

  final Widget Function(BuildContext context, bool hovered) builder;
  final MouseCursor cursor;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _hovered = false;

  void _set(bool value) {
    if (_hovered == value) return;
    setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => _set(true),
      onExit: (_) => _set(false),
      child: FocusableActionDetector(
        onShowFocusHighlight: _set,
        child: widget.builder(context, _hovered),
      ),
    );

    if (widget.onTap != null) {
      child = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: child,
      );
    }
    if (widget.semanticLabel != null) {
      child = Semantics(
        label: widget.semanticLabel,
        button: widget.onTap != null,
        child: child,
      );
    }
    return child;
  }
}

/// A soft breathing ring, used behind the "available" status dot.
class PulseDot extends StatefulWidget {
  const PulseDot({this.color = AppColors.lime, this.size = 8, super.key});

  final Color color;
  final double size;

  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
    );

    if (prefersReducedMotion(context)) return dot;

    return SizedBox(
      width: widget.size * 3,
      height: widget.size * 3,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = Curves.easeOut.transform(_controller.value);
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1 + t * 1.9,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withValues(alpha: 0.35 * (1 - t)),
                  ),
                ),
              ),
              dot,
            ],
          );
        },
      ),
    );
  }
}

/// Infinite, slow horizontal ticker. Used for the hero toolkit strip — it is
/// the one element that keeps moving, which makes the page feel awake.
class Marquee extends StatefulWidget {
  const Marquee({
    required this.children,
    this.speed = 26,
    this.spacing = 34,
    super.key,
  });

  final List<Widget> children;

  /// Logical pixels per second.
  final double speed;
  final double spacing;

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final child in widget.children) ...[
          child,
          SizedBox(width: widget.spacing),
        ],
      ],
    );

    if (prefersReducedMotion(context)) {
      return ClipRect(
        child: Align(alignment: Alignment.centerLeft, child: row),
      );
    }

    return ClipRect(
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            Colors.white,
            Colors.white,
            Colors.transparent,
          ],
          stops: [0, 0.12, 0.88, 1],
        ).createShader(bounds),
        blendMode: BlendMode.dstIn,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                // Drive position from elapsed time so speed is width-agnostic.
                final elapsed = _controller.lastElapsedDuration ?? Duration.zero;
                final travelled = elapsed.inMilliseconds / 1000 * widget.speed;
                return _MarqueeViewport(
                  offset: travelled,
                  child: row,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// Lays the ticker row out twice and wraps the scroll offset by one row width,
/// giving a seamless loop without measuring ahead of time.
class _MarqueeViewport extends StatelessWidget {
  const _MarqueeViewport({required this.offset, required this.child});

  final double offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _MarqueeLayout(offset),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [child, child],
      ),
    );
  }
}

class _MarqueeLayout extends SingleChildLayoutDelegate {
  const _MarqueeLayout(this.offset);

  final double offset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      BoxConstraints.tightFor(height: constraints.maxHeight).copyWith(
        minWidth: 0,
        maxWidth: double.infinity,
      );

  @override
  Size getSize(BoxConstraints constraints) =>
      Size(constraints.maxWidth, constraints.maxHeight.isFinite ? constraints.maxHeight : 30);

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // childSize holds the row twice; wrap on half of it.
    final half = childSize.width / 2;
    if (half <= 0) return Offset.zero;
    return Offset(-(offset % half), 0);
  }

  @override
  bool shouldRelayout(_MarqueeLayout oldDelegate) =>
      oldDelegate.offset != offset;
}
