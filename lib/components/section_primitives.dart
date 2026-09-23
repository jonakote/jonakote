part of '../main.dart';

class StatusTag extends StatelessWidget {
  const StatusTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.lime, shape: BoxShape.circle)),
        const SizedBox(width: 9),
        const Text('INDEPENDENTLY BUILT ON THE WEB', style: TextStyle(color: AppColors.mint, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
      ],
    );
  }
}

class ScrollCue extends StatelessWidget {
  const ScrollCue({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 1, height: 44, color: AppColors.line),
        const SizedBox(width: 14),
        const Text('Scroll to explore', style: TextStyle(color: AppColors.muted, fontSize: 11, letterSpacing: 1.1)),
      ],
    );
  }
}

class Principle extends StatelessWidget {
  const Principle({required this.number, required this.title, required this.copy, super.key});

  final String number;
  final String title;
  final String copy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 245,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: const TextStyle(color: AppColors.lime, fontSize: 11, fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(copy, style: const TextStyle(color: AppColors.muted, fontSize: 12, height: 1.5)),
        ],
      ),
    );
  }
}

class SectionShell extends StatelessWidget {
  const SectionShell({required this.compact, required this.eyebrow, required this.title, required this.child, super.key});

  final bool compact;
  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.fromLTRB(compact ? 22 : 34, 112, compact ? 22 : 34, 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eyebrow, style: const TextStyle(color: AppColors.mint, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.6)),
              const SizedBox(height: 24),
              Text(title, style: TextStyle(fontFamily: 'Space Grotesk', fontSize: compact ? 38 : 54, height: 1.05, letterSpacing: compact ? -1.5 : -2.5, fontWeight: FontWeight.w700)),
              const SizedBox(height: 48),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({required this.label, required this.accent, super.key});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: accent.withValues(alpha: 0.09), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.w800)),
    );
  }
}
