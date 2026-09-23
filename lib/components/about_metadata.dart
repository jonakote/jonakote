part of '../main.dart';

class AboutMeta extends StatelessWidget {
  const AboutMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MetaRow(label: 'FOCUS', value: 'Web experiences'),
        MetaRow(label: 'TOOLKIT', value: 'Flutter · Dart · Design'),
        MetaRow(label: 'BASE', value: 'Curious by default'),
      ],
    );
  }
}

class MetaRow extends StatelessWidget {
  const MetaRow({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.line))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.3)),
          Text(value, style: const TextStyle(color: AppColors.mint, fontSize: 12, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
