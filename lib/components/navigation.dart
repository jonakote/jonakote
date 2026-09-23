part of '../main.dart';

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({required this.compact, required this.onNavigate, super.key});

  final bool compact;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.fromLTRB(compact ? 22 : 34, 24, compact ? 22 : 34, 12),
          child: Row(
            children: [
              const BrandMark(),
              const Spacer(),
              if (!compact) ...[
                NavButton(label: 'Work', onPressed: () => onNavigate('work')),
                NavButton(label: 'About', onPressed: () => onNavigate('about')),
                const SizedBox(width: 16),
              ],
              PillButton(
                label: 'Let’s talk ↗',
                filled: false,
                onPressed: () => onNavigate('contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 31,
          height: 31,
          decoration: BoxDecoration(
            color: AppColors.lime,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Center(
            child: Text(
              'J',
              style: TextStyle(color: AppColors.ink, fontSize: 18, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'jonakote',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: -0.3),
        ),
      ],
    );
  }
}

class NavButton extends StatelessWidget {
  const NavButton({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.muted,
        padding: const EdgeInsets.symmetric(horizontal: 15),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
    );
  }
}

class PillButton extends StatelessWidget {
  const PillButton({required this.label, required this.onPressed, this.filled = true, super.key});

  final String label;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: filled ? AppColors.lime : Colors.transparent,
        foregroundColor: filled ? AppColors.ink : AppColors.mint,
        side: filled ? null : const BorderSide(color: AppColors.line),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
    );
  }
}
