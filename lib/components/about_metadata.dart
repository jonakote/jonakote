part of '../main.dart';

class AboutMeta extends StatelessWidget {
  const AboutMeta({super.key});

  @override
  Widget build(BuildContext context) {
    const rows = [
      ('FOCUS', 'Web experiences'),
      ('TOOLKIT', 'Flutter · Dart · Design'),
      ('BASE', 'Curious by default'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < rows.length; i++)
          Reveal(
            delay: Duration(milliseconds: 90 * i),
            offset: 16,
            child: MetaRow(label: rows[i].$1, value: rows[i].$2),
          ),
      ],
    );
  }
}

/// Label/value row. Hover brightens the value and slides it a touch, which
/// makes the list feel responsive without adding chrome.
class MetaRow extends StatelessWidget {
  const MetaRow({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.basic,
      builder: (context, hovered) => AnimatedContainer(
        duration: AppMotion.fast,
        padding: EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: hovered ? 6 : 0,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: hovered ? AppColors.lineBright : AppColors.line,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: hovered ? AppColors.muted : AppColors.mutedSoft,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.3,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: hovered ? AppColors.lime : AppColors.mint,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
