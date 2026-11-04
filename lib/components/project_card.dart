part of '../main.dart';

/// Work entry. The whole card is one hover/press target: it lifts, its border
/// takes the project accent, a glow fades in, and the visual scales slightly.
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.compact,
    required this.index,
    required this.title,
    required this.description,
    required this.tags,
    required this.accent,
    required this.visual,
    required this.linkLabel,
    required this.linkUrl,
    super.key,
  });

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
    return HoverBuilder(
      onTap: () => openExternalUrl(context, linkUrl),
      semanticLabel: '$title — $linkLabel',
      builder: (context, hovered) {
        final details = ProjectDetails(
          index: index,
          title: title,
          description: description,
          tags: tags,
          accent: accent,
          hovered: hovered,
        );
        final visualColumn = ProjectVisualColumn(
          compact: compact,
          visual: visual,
          linkLabel: linkLabel,
          linkUrl: linkUrl,
          accent: accent,
          hovered: hovered,
        );

        return AnimatedContainer(
          duration: AppMotion.base,
          curve: AppMotion.easeOut,
          transform: Matrix4.translationValues(0, hovered ? -5 : 0, 0),
          padding: EdgeInsets.all(compact ? 24 : 34),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface,
                hovered
                    ? Color.alphaBlend(
                        accent.withValues(alpha: 0.05),
                        AppColors.surfaceRaised,
                      )
                    : AppColors.surface,
              ],
            ),
            borderRadius: BorderRadius.circular(AppMetrics.radiusCard),
            border: Border.all(
              color: hovered
                  ? accent.withValues(alpha: 0.45)
                  : AppColors.line,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: hovered ? 0.14 : 0),
                blurRadius: 42,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    details,
                    const SizedBox(height: 38),
                    visualColumn,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: details),
                    const SizedBox(width: 30),
                    Expanded(flex: 4, child: visualColumn),
                  ],
                ),
        );
      },
    );
  }
}

class ProjectVisualColumn extends StatelessWidget {
  const ProjectVisualColumn({
    required this.compact,
    required this.visual,
    required this.linkLabel,
    required this.linkUrl,
    required this.accent,
    required this.hovered,
    super.key,
  });

  final bool compact;
  final Widget visual;
  final String linkLabel;
  final String linkUrl;
  final Color accent;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.base,
      padding: EdgeInsets.only(left: compact ? 0 : 30, top: compact ? 0 : 2),
      decoration: compact
          ? null
          : BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: hovered
                      ? accent.withValues(alpha: 0.35)
                      : AppColors.line,
                ),
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ProjectLink(
              label: linkLabel,
              url: linkUrl,
              accent: accent,
              parentHovered: hovered,
            ),
          ),
          SizedBox(height: compact ? 18 : 12),
          SizedBox(
            height: compact ? 190 : 240,
            width: double.infinity,
            child: AnimatedScale(
              duration: AppMotion.base,
              curve: AppMotion.easeOut,
              scale: hovered ? 1.03 : 1,
              child: visual,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectLink extends StatelessWidget {
  const ProjectLink({
    required this.label,
    required this.url,
    required this.accent,
    this.parentHovered = false,
    super.key,
  });

  final String label;
  final String url;
  final Color accent;
  final bool parentHovered;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: () => openExternalUrl(context, url),
      semanticLabel: label,
      builder: (context, hovered) {
        final lit = hovered || parentHovered;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: AppType.body,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
                color: lit ? accent : AppColors.muted,
              ),
            ),
            const SizedBox(width: 6),
            AnimatedSlide(
              duration: AppMotion.base,
              curve: AppMotion.emphasized,
              offset: Offset(lit ? 0.22 : 0, lit ? -0.22 : 0),
              child: Icon(
                Icons.arrow_outward_rounded,
                size: 14,
                color: lit ? accent : AppColors.muted,
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({
    required this.index,
    required this.title,
    required this.description,
    required this.tags,
    required this.accent,
    this.hovered = false,
    super.key,
  });

  final String index;
  final String title;
  final String description;
  final List<String> tags;
  final Color accent;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AnimatedContainer(
              duration: AppMotion.base,
              curve: AppMotion.emphasized,
              height: 1.5,
              width: hovered ? 34 : 14,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              index,
              style: TextStyle(
                color: accent,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        AnimatedDefaultTextStyle(
          duration: AppMotion.base,
          style: TextStyle(
            fontFamily: AppType.display,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
            color: hovered ? accent : Colors.white,
          ),
          child: Text(title),
        ),
        const SizedBox(height: 14),
        Text(
          description,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 13.5,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in tags) Tag(label: tag, accent: accent),
          ],
        ),
      ],
    );
  }
}
