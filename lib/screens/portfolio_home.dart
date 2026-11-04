part of '../main.dart';

class PortfolioKeys {
  static final byName = <String, GlobalKey>{
    'work': GlobalKey(),
    'about': GlobalKey(),
    'contact': GlobalKey(),
  };
}

/// Page shell. Owns the single [ScrollController] that every scroll-driven
/// effect reads from: reveals, nav elevation, active-section state, the
/// progress bar, and the back-to-top button.
class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _controller = ScrollController();

  double _progress = 0;
  double _navElevation = 0;
  bool _showBackToTop = false;
  bool _menuOpen = false;
  String? _activeSection;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final offset = _controller.offset;
    final max = _controller.position.maxScrollExtent;

    final progress = max <= 0 ? 0.0 : (offset / max).clamp(0.0, 1.0);
    final elevation = (offset / 70).clamp(0.0, 1.0);
    final showBackToTop = offset > 640;
    final active = _resolveActiveSection();

    if (progress != _progress ||
        elevation != _navElevation ||
        showBackToTop != _showBackToTop ||
        active != _activeSection) {
      setState(() {
        _progress = progress;
        _navElevation = elevation;
        _showBackToTop = showBackToTop;
        _activeSection = active;
      });
    }
  }

  /// The section whose top edge most recently passed under the nav bar.
  String? _resolveActiveSection() {
    const threshold = AppMetrics.navHeight + 140;
    String? active;
    for (final name in const ['work', 'about', 'contact']) {
      final box =
          PortfolioKeys.byName[name]?.currentContext?.findRenderObject()
              as RenderBox?;
      if (box == null || !box.hasSize) continue;
      if (box.localToGlobal(Offset.zero).dy <= threshold) active = name;
    }
    return active;
  }

  Future<void> _scrollTo(String section) async {
    if (_menuOpen) setState(() => _menuOpen = false);

    if (section == 'top') {
      await _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 620),
        curve: AppMotion.emphasized,
      );
      return;
    }

    final target = PortfolioKeys.byName[section]?.currentContext;
    if (target == null || !_controller.hasClients) return;
    final box = target.findRenderObject() as RenderBox?;
    if (box == null) return;

    final destination = _controller.offset +
        box.localToGlobal(Offset.zero).dy -
        AppMetrics.navHeight -
        16;

    await _controller.animateTo(
      destination.clamp(0.0, _controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 680),
      curve: AppMotion.emphasized,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 760;

            return PortfolioScroll(
              controller: _controller,
              child: Stack(
                children: [
                  const Positioned.fill(child: AuroraBackdrop()),
                  Positioned.fill(
                    child: Scrollbar(
                      controller: _controller,
                      child: CustomScrollView(
                        controller: _controller,
                        slivers: [
                          const SliverToBoxAdapter(
                            child: SizedBox(height: AppMetrics.navHeight),
                          ),
                          SliverToBoxAdapter(
                            child: HeroSection(
                              compact: compact,
                              onExplore: () => _scrollTo('work'),
                              onContact: () => _scrollTo('contact'),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: PrinciplesSection(compact: compact),
                          ),
                          SliverToBoxAdapter(
                            child: WorkSection(
                              key: PortfolioKeys.byName['work'],
                              compact: compact,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: AboutSection(
                              key: PortfolioKeys.byName['about'],
                              compact: compact,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ContactSection(
                              key: PortfolioKeys.byName['contact'],
                              compact: compact,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: PortfolioFooter(compact: compact),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Top chrome: nav bar, mobile sheet, progress rule.
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        PortfolioNavBar(
                          compact: compact,
                          onNavigate: _scrollTo,
                          activeSection: _activeSection,
                          elevation: _navElevation,
                          menuOpen: _menuOpen,
                          onToggleMenu: () =>
                              setState(() => _menuOpen = !_menuOpen),
                        ),
                        AnimatedSwitcher(
                          duration: AppMotion.base,
                          switchInCurve: AppMotion.emphasized,
                          transitionBuilder: (child, animation) =>
                              SizeTransition(
                            sizeFactor: animation,
                            alignment: Alignment.topCenter,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          ),
                          child: _menuOpen && compact
                              ? MobileMenu(onNavigate: _scrollTo)
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ScrollProgressBar(progress: _progress),
                  ),

                  Positioned(
                    right: compact ? 18 : 28,
                    bottom: compact ? 18 : 28,
                    child: BackToTopButton(
                      visible: _showBackToTop,
                      onPressed: () => _scrollTo('top'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
