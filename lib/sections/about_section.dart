part of '../main.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: SectionShell(
        compact: compact,
        eyebrow: 'A LITTLE CONTEXT',
        title: 'Good work feels\nclear, not loud.',
        child: compact
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutCopy(),
                  SizedBox(height: 30),
                  AboutMeta(),
                ],
              )
            : const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: AboutCopy()),
                  SizedBox(width: 100),
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
    return const Text(
      'This is a living space for the things I make and the ideas I am exploring. The thread through it all is simple: make technology feel more human, more useful, and easier to understand.',
      style: TextStyle(color: Colors.white, fontSize: 18, height: 1.6),
    );
  }
}
