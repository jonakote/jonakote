import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

part 'theme/app_colors.dart';
part 'theme/social_links.dart';
part 'screens/portfolio_home.dart';
part 'components/motion.dart';
part 'components/backdrop.dart';
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

/// Opens [url] in a new tab, surfacing a message if the browser blocks it.
Future<void> openExternalUrl(BuildContext context, String url) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final opened = await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  if (!opened) {
    messenger?.showSnackBar(
      SnackBar(
        content: Text('Could not open $url'),
        backgroundColor: AppColors.surfaceRaised,
      ),
    );
  }
}

/// Opens the visitor's mail client. Uses `_self` rather than `_blank`: the
/// browser hands a `mailto:` off to the mail handler without navigating, so
/// `_blank` would just leave an empty tab behind.
Future<void> openMailto(BuildContext context, String url) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final opened = await launchUrl(Uri.parse(url), webOnlyWindowName: '_self');
  if (!opened) {
    messenger?.showSnackBar(
      const SnackBar(
        content: Text('Could not open your mail app — '
            '${SocialLinks.email}'),
        backgroundColor: AppColors.surfaceRaised,
      ),
    );
  }
}

class JonakotePortfolio extends StatelessWidget {
  const JonakotePortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.lime,
      brightness: Brightness.dark,
    ).copyWith(
      surface: AppColors.ink,
      onSurface: Colors.white,
    );

    return MaterialApp(
      title: 'Joshua Tetteh — Digital experiences, thoughtfully built',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.ink,
        colorScheme: colorScheme,
        fontFamily: AppType.body,
        useMaterial3: true,
        // Default body copy: slightly looser lines than Material's defaults,
        // which suits long-form editorial text much better.
        textTheme: const TextTheme(
          bodyLarge: TextStyle(height: 1.7, color: Colors.white),
          bodyMedium: TextStyle(height: 1.7, color: Colors.white),
          bodySmall: TextStyle(height: 1.6, color: AppColors.muted),
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.lime.withValues(alpha: 0.28),
          cursorColor: AppColors.lime,
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.hovered)
                ? AppColors.lineBright
                : AppColors.line,
          ),
          thickness: const WidgetStatePropertyAll(6),
          radius: const Radius.circular(3),
          crossAxisMargin: 2,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.surfaceRaised,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.line),
          ),
          textStyle: const TextStyle(color: AppColors.muted, fontSize: 11),
        ),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      home: const PortfolioHome(),
    );
  }
}
