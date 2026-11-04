part of '../main.dart';

/// Three operating principles on a banded surface, revealed left to right.
class PrinciplesSection extends StatelessWidget {
  const PrinciplesSection({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    const principles = [
      ('01', 'Clarity first', 'Simple ideas deserve simple interfaces.'),
      ('02', 'Built to last', 'Small details, solid foundations, no noise.'),
      ('03', 'Always curious', 'The best work starts with better questions.'),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.72),
        border: const Border(
          top: BorderSide(color: AppColors.line),
          bottom: BorderSide(color: AppColors.line),
        ),
      ),
      child: ContentShell(
        padding: EdgeInsets.symmetric(
          horizontal: AppMetrics.gutter(compact),
          vertical: compact ? 48 : 62,
        ),
        child: Wrap(
          spacing: compact ? 30 : 64,
          runSpacing: 34,
          children: [
            for (var i = 0; i < principles.length; i++)
              Reveal(
                delay: Duration(milliseconds: 110 * i),
                child: Principle(
                  number: principles[i].$1,
                  title: principles[i].$2,
                  copy: principles[i].$3,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
