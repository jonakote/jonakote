part of '../main.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({required this.compact, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.fromLTRB(compact ? 22 : 34, 126, compact ? 22 : 34, 126),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('OPEN TO GOOD CONVERSATIONS', style: TextStyle(color: AppColors.mint, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.6)),
              const SizedBox(height: 22),
              Text('Have something\nworth building?', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: compact ? 48 : 72, height: .98, letterSpacing: compact ? -2 : -3.8, fontWeight: FontWeight.w700)),
              const SizedBox(height: 32),
              const Text('Find me on GitHub and let’s start there.', style: TextStyle(color: AppColors.muted, fontSize: 16)),
              const SizedBox(height: 30),
              PillButton(label: 'github.com/jonakote ↗', onPressed: () => _openGitHub(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _openGitHub(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Visit github.com/jonakote to connect.')));
  }
}
