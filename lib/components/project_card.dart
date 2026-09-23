part of '../main.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.compact, required this.index, required this.title, required this.description, required this.tags, required this.accent, required this.visual, super.key});

  final bool compact;
  final String index;
  final String title;
  final String description;
  final List<String> tags;
  final Color accent;
  final Widget visual;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(compact ? 24 : 34),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.line)),
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProjectDetails(index: index, title: title, description: description, tags: tags, accent: accent),
                const SizedBox(height: 42),
                SizedBox(height: 190, width: double.infinity, child: visual),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ProjectDetails(index: index, title: title, description: description, tags: tags, accent: accent)),
                const SizedBox(width: 30),
                Expanded(flex: 4, child: SizedBox(height: 240, width: double.infinity, child: visual)),
              ],
            ),
    );
  }
}

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({required this.index, required this.title, required this.description, required this.tags, required this.accent, super.key});

  final String index;
  final String title;
  final String description;
  final List<String> tags;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(index, style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w800)),
        const SizedBox(height: 46),
        Text(title, style: const TextStyle(fontFamily: 'Space Grotesk', fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: -0.8)),
        const SizedBox(height: 14),
        Text(description, style: const TextStyle(color: AppColors.muted, fontSize: 13, height: 1.65)),
        const SizedBox(height: 25),
        Wrap(spacing: 8, runSpacing: 8, children: tags.map((tag) => Tag(label: tag, accent: accent)).toList()),
      ],
    );
  }
}
