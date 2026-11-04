part of '../main.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.72),
        border: const Border(
          top: BorderSide(color: AppColors.line),
          bottom: BorderSide(color: AppColors.line),
        ),
      ),
      child: SectionShell(
        compact: compact,
        eyebrow: 'A LITTLE CONTEXT',
        title: 'Good work feels\nclear, not loud.',
        child: compact
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutCopy(),
                  SizedBox(height: 34),
                  AboutMeta(),
                ],
              )
            : const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: AboutCopy()),
                  SizedBox(width: 90),
                  Expanded(flex: 4, child: AboutMeta()),
                ],
              ),
      ),
    );
  }
}

class AboutCopy extends StatelessWidget {
  const AboutCopy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lead line sits larger than the rest to give the block a clear entry.
        Text(
          'This is a living space for the things I make and the ideas I am '
          'exploring.',
          style: TextStyle(
            color: Colors.white,
            fontSize: AppType.fluid(context, min: 19, max: 23),
            height: 1.5,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'The thread through it all is simple: make technology feel more '
          'human, more useful, and easier to understand.',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 16.5,
            height: 1.75,
          ),
        ),
      ],
    );
  }
}
