part of '../main.dart';

class PortfolioKeys {
  static final byName = <String, GlobalKey>{
    'work': GlobalKey(),
    'about': GlobalKey(),
    'contact': GlobalKey(),
  };
}

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({super.key});

  void _scrollTo(BuildContext context, String section) {
    final target = switch (section) {
      'work' => 'work',
      'about' => 'about',
      'contact' => 'contact',
      _ => null,
    };
    if (target != null) {
      Scrollable.ensureVisible(
        PortfolioKeys.byName[target]!.currentContext!,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 760;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: PortfolioNavBar(
                    compact: isCompact,
                    onNavigate: (section) => _scrollTo(context, section),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HeroSection(
                    compact: isCompact,
                    onExplore: () => _scrollTo(context, 'work'),
                  ),
                ),
                SliverToBoxAdapter(child: PrinciplesSection(compact: isCompact)),
                SliverToBoxAdapter(
                  child: WorkSection(key: PortfolioKeys.byName['work'], compact: isCompact),
                ),
                SliverToBoxAdapter(
                  child: AboutSection(key: PortfolioKeys.byName['about'], compact: isCompact),
                ),
                SliverToBoxAdapter(
                  child: ContactSection(
                    key: PortfolioKeys.byName['contact'],
                    compact: isCompact,
                  ),
                ),
                const SliverToBoxAdapter(child: PortfolioFooter()),
              ],
            );
          },
        ),
      ),
    );
  }
}
