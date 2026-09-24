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
            description: 'An environmental and waste-management platform pairing a Flutter app with a Django operations dashboard for community reports, service requests, analytics, and organization-scoped response workflows.',
            tags: const ['Flutter', 'Dart', 'Django', 'Waste management'],
            accent: AppColors.mint,
            visual: const TydizenVisual(),
            linkLabel: 'View project ↗',
            linkUrl: SocialLinks.tydizenApp,
          ),
        ],
      ),
    );
  }
}
