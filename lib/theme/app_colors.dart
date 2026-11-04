part of '../main.dart';

abstract final class AppColors {
  /// Page base. Slightly deeper than before so accent glows read as light.
  static const ink = Color(0xFF070909);
  static const inkSoft = Color(0xFF0B0E0D);

  /// Elevated panels.
  static const surface = Color(0xFF0F1413);
  static const surfaceRaised = Color(0xFF151B1A);

  /// Hairlines.
  static const line = Color(0xFF212927);
  static const lineBright = Color(0xFF33423E);

  /// Text.
  static const muted = Color(0xFF93A19D);
  static const mutedSoft = Color(0xFF6A7673);

  /// Accents.
  static const lime = Color(0xFFD7F36B);
  static const mint = Color(0xFF9EE7C2);
  static const coral = Color(0xFFFF9D7A);
  static const violet = Color(0xFF9E8BFF);

  static const accentSweep = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [lime, mint],
  );
}

/// Shared geometry tokens so spacing stays consistent across sections.
abstract final class AppMetrics {
  static const maxContentWidth = 1180.0;
  static const navHeight = 72.0;
  static const radiusCard = 26.0;

  static double gutter(bool compact) => compact ? 22 : 34;
}

/// Shared motion tokens so every transition feels like one system.
abstract final class AppMotion {
  static const fast = Duration(milliseconds: 180);
  static const base = Duration(milliseconds: 320);
  static const reveal = Duration(milliseconds: 720);
  static const easeOut = Curves.easeOutCubic;
  static const emphasized = Cubic(0.2, 0.9, 0.1, 1);
}

abstract final class AppType {
  static const display = 'Space Grotesk';
  static const body = 'Manrope';

  /// Interpolates a font size between two viewport widths, so display type
  /// never looks stranded on mid-size screens.
  static double fluid(
    BuildContext context, {
    required double min,
    required double max,
    double from = 380,
    double to = 1280,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    final t = ((width - from) / (to - from)).clamp(0.0, 1.0);
    return min + (max - min) * t;
  }
}
