part of '../main.dart';

class PrinciplesSection extends StatelessWidget {
  const PrinciplesSection({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: compact ? 22 : 34, vertical: 58),
            child: Wrap(
              spacing: compact ? 30 : 70,
              runSpacing: 30,
              children: const [
                Principle(number: '01', title: 'Clarity first', copy: 'Simple ideas deserve simple interfaces.'),
                Principle(number: '02', title: 'Built to last', copy: 'Small details, solid foundations, no noise.'),
                Principle(number: '03', title: 'Always curious', copy: 'The best work starts with better questions.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
