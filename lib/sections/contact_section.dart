part of '../main.dart';

/// Closing call to action: oversized headline, the two real channels, and a
/// copy-the-handle shortcut for people who'd rather not leave the page.
class ContactSection extends StatelessWidget {
  const ContactSection({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final gutter = AppMetrics.gutter(compact);
    final titleSize = AppType.fluid(context, min: 42, max: 76);

    return ContentShell(
      padding: EdgeInsets.fromLTRB(
        gutter,
        compact ? 96 : 132,
        gutter,
        compact ? 96 : 132,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Reveal(
            child: SectionEyebrow(label: 'OPEN TO GOOD CONVERSATIONS'),
          ),
          const SizedBox(height: 22),
          Reveal(
            delay: const Duration(milliseconds: 80),
            child: Text(
              'Have something\nworth building?',
              style: TextStyle(
                fontFamily: AppType.display,
                fontSize: titleSize,
                height: 0.98,
                letterSpacing: titleSize * -0.05,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 28),
          const Reveal(
            delay: Duration(milliseconds: 140),
            child: Text(
              'Find me on GitHub and let’s start there.',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 16.5,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Reveal(
            delay: const Duration(milliseconds: 200),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                PillButton(
                  label: 'GitHub',
                  trailing: '↗',
                  onPressed: () =>
                      openExternalUrl(context, SocialLinks.github),
                ),
                PillButton(
                  label: 'LinkedIn',
                  trailing: '↗',
                  filled: false,
                  onPressed: () =>
                      openExternalUrl(context, SocialLinks.linkedin),
                ),
                const CopyHandleChip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Click-to-copy handle. Confirms inline rather than with a snackbar, so the
/// feedback lands where the eye already is.
class CopyHandleChip extends StatefulWidget {
  const CopyHandleChip({super.key});

  @override
  State<CopyHandleChip> createState() => _CopyHandleChipState();
}

class _CopyHandleChipState extends State<CopyHandleChip> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: 'jonakote'));
    if (!mounted) return;
    setState(() => _copied = true);
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: _copy,
      semanticLabel: 'Copy GitHub handle jonakote',
      builder: (context, hovered) => AnimatedContainer(
        duration: AppMotion.base,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: hovered ? AppColors.surfaceRaised : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: _copied ? AppColors.lime : AppColors.line,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _copied ? Icons.check_rounded : Icons.content_copy_rounded,
              size: 13,
              color: _copied ? AppColors.lime : AppColors.mutedSoft,
            ),
            const SizedBox(width: 8),
            Text(
              _copied ? 'Copied' : '@jonakote',
              style: TextStyle(
                fontFamily: AppType.body,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: _copied ? AppColors.lime : AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
