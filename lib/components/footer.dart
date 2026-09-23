part of '../main.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 34),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.line))),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Row(
            children: [
              const Text('© 2026 jonakote', style: TextStyle(color: AppColors.muted, fontSize: 11)),
              const Spacer(),
              Text('Made for the web · Flutter', style: TextStyle(color: AppColors.muted.withValues(alpha: .7), fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
