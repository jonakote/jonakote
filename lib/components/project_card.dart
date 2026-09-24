part of '../main.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.compact, required this.index, required this.title, required this.description, required this.tags, required this.accent, required this.visual, required this.linkLabel, required this.linkUrl, super.key});

  final bool compact;
  final String index;
  final String title;
  final String description;
  final List<String> tags;
  final Color accent;
  final Widget visual;
  final String linkLabel;
  final String linkUrl;

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
                ProjectVisualColumn(
                  compact: true,
                  visual: visual,
                  linkLabel: linkLabel,
                  linkUrl: linkUrl,
                  accent: accent,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: ProjectDetails(index: index, title: title, description: description, tags: tags, accent: accent),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 4,
                  child: ProjectVisualColumn(
                    compact: false,
                    visual: visual,
                    linkLabel: linkLabel,
                    linkUrl: linkUrl,
                    accent: accent,
                  ),
                ),
              ],
            ),
    );
  }
}

class ProjectVisualColumn extends StatelessWidget {
  const ProjectVisualColumn({required this.compact, required this.visual, required this.linkLabel, required this.linkUrl, required this.accent, super.key});

  final bool compact;
  final Widget visual;
  final String linkLabel;
  final String linkUrl;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: compact ? 0 : 30, top: compact ? 0 : 2),
      decoration: compact ? null : const BoxDecoration(border: Border(left: BorderSide(color: AppColors.line))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ProjectLink(label: linkLabel, url: linkUrl, accent: accent),
          ),
          SizedBox(height: compact ? 18 : 12),
          SizedBox(height: compact ? 190 : 240, width: double.infinity, child: visual),
        ],
      ),
    );
  }
}

class ProjectLink extends StatelessWidget {
  const ProjectLink({required this.label, required this.url, required this.accent, super.key});

  final String label;
  final String url;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _open(context),
      icon: const Icon(Icons.arrow_outward, size: 14),
      label: Text(label),
      style: TextButton.styleFrom(
        foregroundColor: accent,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
      ),
    );
  }

  Future<void> _open(BuildContext context) async {
    final opened = await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
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
