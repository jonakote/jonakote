part of '../main.dart';

class WorkSection extends StatelessWidget {
  const WorkSection({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      compact: compact,
      eyebrow: 'SELECTED WORK & ACTIVITY',
      title: 'Projects with a\npoint of view.',
      child: Column(
        children: [
          ProjectCard(
            compact: compact,
            index: '01',
            title: 'Joshua Tetteh / Portfolio',
            description: 'A focused home for work, ideas, and the next conversation — designed as a fast, expressive Flutter web experience.',
            tags: const ['Flutter Web', 'Responsive UI', 'SEO-ready'],
            accent: AppColors.lime,
            visual: const OrbitVisual(),
            linkLabel: 'View source ↗',
            linkUrl: SocialLinks.github,
          ),
          const SizedBox(height: 18),
          ProjectCard(
            compact: compact,
            index: '02',
            title: 'Tydizen',
            description: 'A project in progress, taking shape around useful digital experiences and a clear product point of view.',
            tags: const ['Tydizen', 'Product', 'In progress'],
            accent: AppColors.mint,
            visual: const TydizenVisual(),
            linkLabel: 'See more work ↗',
            linkUrl: SocialLinks.github,
          ),
          const SizedBox(height: 18),
          ProjectCard(
            compact: compact,
            index: '03',
            title: 'Notification POC',
            description: 'An early product exploration helping move notification functionality from an idea toward a clear, testable experience.',
            tags: const ['Proof of concept', 'Notification flow', 'In progress'],
            accent: AppColors.coral,
            visual: const SignalVisual(),
            linkLabel: 'See more work ↗',
            linkUrl: SocialLinks.github,
          ),
        ],
      ),
    );
  }
}
