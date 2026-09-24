import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';

part 'theme/app_colors.dart';
part 'theme/social_links.dart';
part 'screens/portfolio_home.dart';
part 'components/navigation.dart';
part 'components/section_primitives.dart';
part 'components/project_card.dart';
part 'components/project_visuals.dart';
part 'components/about_metadata.dart';
part 'components/footer.dart';
part 'sections/hero_section.dart';
part 'sections/principles_section.dart';
part 'sections/work_section.dart';
part 'sections/about_section.dart';
part 'sections/contact_section.dart';

void main() {
  runApp(const JonakotePortfolio());
}

class JonakotePortfolio extends StatelessWidget {
  const JonakotePortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joshua Tetteh — Digital experiences, thoughtfully built',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.ink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.lime,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Manrope',
        useMaterial3: true,
      ),
      home: const PortfolioHome(),
    );
  }
}
