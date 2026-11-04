part of '../main.dart';

/// Floating, frosted top bar. It starts transparent over the hero and gains a
/// blurred panel + hairline once the page scrolls, so it never fights the
/// headline for attention.
class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({
    required this.compact,
    required this.onNavigate,
    required this.activeSection,
    required this.elevation,
    required this.menuOpen,
    required this.onToggleMenu,
    super.key,
  });

  final bool compact;
  final ValueChanged<String> onNavigate;

  /// 'work' | 'about' | 'contact' | null
  final String? activeSection;

  /// 0..1 — how far the bar has transitioned into its scrolled state.
  final double elevation;

  final bool menuOpen;
  final VoidCallback onToggleMenu;

  @override
  Widget build(BuildContext context) {
    final gutter = AppMetrics.gutter(compact);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18 * elevation,
          sigmaY: 18 * elevation,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.ink.withValues(alpha: 0.72 * elevation),
            border: Border(
              bottom: BorderSide(
                color: AppColors.line.withValues(alpha: elevation),
              ),
            ),
          ),
          child: SizedBox(
            height: AppMetrics.navHeight,
            child: ContentShell(
              padding: EdgeInsets.symmetric(horizontal: gutter),
              child: Row(
                children: [
                  BrandMark(onTap: () => onNavigate('top')),
                  const Spacer(),
                  if (!compact) ...[
                    NavButton(
                      label: 'Work',
                      active: activeSection == 'work',
                      onPressed: () => onNavigate('work'),
                    ),
                    NavButton(
                      label: 'About',
                      active: activeSection == 'about',
                      onPressed: () => onNavigate('about'),
                    ),
                    const SizedBox(width: 18),
                    PillButton(
                      label: 'Let’s talk',
                      trailing: '↗',
                      filled: false,
                      onPressed: () =>
                          openMailto(context, SocialLinks.enquiryMailto),
                    ),
                  ] else
                    MenuToggle(open: menuOpen, onPressed: onToggleMenu),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onTap,
      semanticLabel: 'Joshua Tetteh — back to top',
      builder: (context, hovered) => Row(
        children: [
          AnimatedContainer(
            duration: AppMotion.base,
            curve: AppMotion.easeOut,
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: AppColors.accentSweep,
              borderRadius: BorderRadius.circular(hovered ? 16 : 10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lime.withValues(alpha: hovered ? 0.4 : 0.14),
                  blurRadius: hovered ? 22 : 12,
                  spreadRadius: hovered ? 1 : 0,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'J',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 11),
          AnimatedDefaultTextStyle(
            duration: AppMotion.base,
            style: TextStyle(
              fontFamily: AppType.body,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: hovered ? AppColors.lime : Colors.white,
            ),
            child: const Text('Joshua Tetteh'),
          ),
        ],
      ),
    );
  }
}

/// Text link with an underline that sweeps in on hover and stays put while its
/// section is the one in view.
class NavButton extends StatelessWidget {
  const NavButton({
    required this.label,
    required this.onPressed,
    this.active = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onPressed,
      semanticLabel: label,
      builder: (context, hovered) {
        final lit = hovered || active;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: AppMotion.fast,
                style: TextStyle(
                  fontFamily: AppType.body,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: active
                      ? AppColors.lime
                      : hovered
                          ? Colors.white
                          : AppColors.muted,
                ),
                child: Text(label),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: AppMotion.base,
                curve: AppMotion.emphasized,
                height: 1.5,
                width: lit ? 18 : 0,
                decoration: BoxDecoration(
                  color: active ? AppColors.lime : AppColors.mint,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Primary call to action. Lifts and glows on hover; the trailing glyph slides.
class PillButton extends StatelessWidget {
  const PillButton({
    required this.label,
    required this.onPressed,
    this.filled = true,
    this.trailing,
    this.accent = AppColors.lime,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool filled;
  final String? trailing;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onPressed,
      semanticLabel: label,
      builder: (context, hovered) {
        final lift = hovered ? -2.0 : 0.0;
        return Transform.translate(
          offset: Offset(0, lift),
          child: AnimatedContainer(
            duration: AppMotion.base,
            curve: AppMotion.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: filled
                  ? accent
                  : hovered
                      ? AppColors.mint.withValues(alpha: 0.08)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
              border: filled
                  ? null
                  : Border.all(
                      color: hovered ? AppColors.mint : AppColors.line,
                    ),
              boxShadow: filled
                  ? [
                      BoxShadow(
                        color: accent.withValues(alpha: hovered ? 0.34 : 0.12),
                        blurRadius: hovered ? 26 : 14,
                        offset: Offset(0, hovered ? 8 : 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: AppType.body,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.1,
                    color: filled ? AppColors.ink : AppColors.mint,
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 8),
                  AnimatedSlide(
                    duration: AppMotion.base,
                    curve: AppMotion.emphasized,
                    offset: Offset(hovered ? 0.28 : 0, hovered ? -0.18 : 0),
                    child: Text(
                      trailing!,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: filled ? AppColors.ink : AppColors.mint,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Compact-layout hamburger that morphs into a close glyph.
class MenuToggle extends StatelessWidget {
  const MenuToggle({required this.open, required this.onPressed, super.key});

  final bool open;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: onPressed,
      semanticLabel: open ? 'Close menu' : 'Open menu',
      builder: (context, hovered) => AnimatedContainer(
        duration: AppMotion.base,
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: hovered || open
              ? AppColors.mint.withValues(alpha: 0.08)
              : Colors.transparent,
          border: Border.all(color: open ? AppColors.mint : AppColors.line),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: AnimatedRotation(
            duration: AppMotion.base,
            curve: AppMotion.emphasized,
            turns: open ? 0.5 : 0,
            child: Icon(
              open ? Icons.close_rounded : Icons.menu_rounded,
              size: 20,
              color: open ? AppColors.mint : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-width sheet shown under the bar on small screens.
class MobileMenu extends StatelessWidget {
  const MobileMenu({required this.onNavigate, super.key});

  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    const items = <String, String>{
      'work': 'Work',
      'about': 'About',
      'contact': 'Contact',
    };

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.ink.withValues(alpha: 0.9),
            border: const Border(
              bottom: BorderSide(color: AppColors.line),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final entry in items.entries)
                HoverBuilder(
                  onTap: () => onNavigate(entry.key),
                  semanticLabel: entry.value,
                  builder: (context, hovered) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.line),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.value,
                          style: TextStyle(
                            fontFamily: AppType.display,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.6,
                            color: hovered ? AppColors.lime : Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_downward_rounded,
                          size: 18,
                          color: hovered ? AppColors.lime : AppColors.mutedSoft,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Thin gradient bar pinned to the very top showing read progress.
class ScrollProgressBar extends StatelessWidget {
  const ScrollProgressBar({required this.progress, super.key});

  /// 0..1
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.accentSweep,
              boxShadow: [
                BoxShadow(color: AppColors.lime, blurRadius: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Appears once the hero is out of view.
class BackToTopButton extends StatelessWidget {
  const BackToTopButton({
    required this.visible,
    required this.onPressed,
    super.key,
  });

  final bool visible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedSlide(
        duration: AppMotion.base,
        curve: AppMotion.emphasized,
        offset: Offset(0, visible ? 0 : 0.6),
        child: AnimatedOpacity(
          duration: AppMotion.base,
          opacity: visible ? 1 : 0,
          child: HoverBuilder(
            onTap: onPressed,
            semanticLabel: 'Back to top',
            builder: (context, hovered) => AnimatedContainer(
              duration: AppMotion.base,
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: hovered ? AppColors.lime : AppColors.surfaceRaised,
                shape: BoxShape.circle,
                border: Border.all(
                  color: hovered ? AppColors.lime : AppColors.line,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lime
                        .withValues(alpha: hovered ? 0.35 : 0),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_upward_rounded,
                size: 20,
                color: hovered ? AppColors.ink : AppColors.muted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
