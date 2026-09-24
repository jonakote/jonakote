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
          child: const Row(
            children: [
              Text('© 2026 Joshua Tetteh', style: TextStyle(color: AppColors.muted, fontSize: 11)),
              Spacer(),
              FooterCredit(),
            ],
          ),
        ),
      ),
    );
  }
}

class FooterCredit extends StatelessWidget {
  const FooterCredit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Made with', style: TextStyle(color: AppColors.muted, fontSize: 11)),
        SizedBox(width: 5),
        Icon(Icons.favorite, color: AppColors.coral, size: 13),
        SizedBox(width: 9),
        Text('with', style: TextStyle(color: AppColors.muted, fontSize: 11)),
        SizedBox(width: 7),
        FlutterLogo(size: 16, style: FlutterLogoStyle.markOnly),
        SizedBox(width: 5),
        Text('Flutter', style: TextStyle(color: AppColors.mint, fontSize: 11, fontWeight: FontWeight.w700)),
        SizedBox(width: 9),
        Text('&', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
        SizedBox(width: 9),
        ChatGptMark(),
        SizedBox(width: 5),
        Text('Codex', style: TextStyle(color: AppColors.mint, fontSize: 11, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class ChatGptMark extends StatelessWidget {
  const ChatGptMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      message: 'ChatGPT icon',
      child: Image(
        image: AssetImage('assets/brand/chatgpt.png'),
        width: 16,
        height: 16,
        fit: BoxFit.contain,
        color: AppColors.mint,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}
