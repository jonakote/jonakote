part of '../main.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({required this.compact, required this.onExplore, super.key});

  final bool compact;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.fromLTRB(compact ? 22 : 34, compact ? 70 : 120, compact ? 22 : 34, 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StatusTag(),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Space Grotesk',
                    fontSize: compact ? 52 : 86,
                    height: 0.98,
                    letterSpacing: compact ? -2.4 : -4.8,
                    fontWeight: FontWeight.w700,
                  ),
                  children: const [
                    TextSpan(text: 'Digital things\n'),
                    TextSpan(text: 'with '),
                    TextSpan(text: 'intent.', style: TextStyle(color: AppColors.lime)),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 510),
                child: const Text(
                  'I’m Joshua Tetteh — a builder interested in the space where useful products, clear interfaces, and thoughtful code meet.',
                  style: TextStyle(color: AppColors.muted, fontSize: 17, height: 1.65),
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  PillButton(label: 'Explore the work ↓', onPressed: onExplore),
                  const SizedBox(width: 22),
                  const Text('Flutter · Dart · Product thinking', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 92),
              const ScrollCue(),
            ],
          ),
        ),
      ),
    );
  }
}
