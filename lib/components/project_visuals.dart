part of '../main.dart';

class OrbitVisual extends StatelessWidget {
  const OrbitVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.circle,
          radarBackgroundColor: AppColors.lime.withValues(alpha: .025),
          radarBorderData: const BorderSide(color: AppColors.line, width: 1),
          gridBorderData: const BorderSide(color: AppColors.line, width: 1),
          tickBorderData: BorderSide.none,
          tickCount: 3,
          ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
          titlePositionPercentageOffset: .18,
          titleTextStyle: const TextStyle(color: AppColors.muted, fontSize: 9, fontWeight: FontWeight.w700),
          getTitle: (index, angle) => RadarChartTitle(
            text: const ['Ideas', 'Flow', 'Craft', 'Clarity', 'Curiosity'][index],
          ),
          dataSets: [
            RadarDataSet(
              dataEntries: const [
                RadarEntry(value: 4.6),
                RadarEntry(value: 3.9),
                RadarEntry(value: 4.8),
                RadarEntry(value: 4.4),
                RadarEntry(value: 4.1),
              ],
              fillColor: AppColors.lime.withValues(alpha: .16),
              borderColor: AppColors.lime,
              borderWidth: 2,
              entryRadius: 3,
            ),
          ],
          radarTouchData: RadarTouchData(enabled: false),
        ),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
      ),
    );
  }
}

class TydizenVisual extends StatelessWidget {
  const TydizenVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
      child: BarChart(
        BarChartData(
          maxY: 10,
          minY: 0,
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 2.5,
            getDrawingHorizontalLine: (_) => FlLine(
              color: AppColors.line.withValues(alpha: .7),
              strokeWidth: 1,
              dashArray: [4, 7],
            ),
          ),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: const BarTouchData(enabled: false),
          barGroups: [
            _bar(0, 4.2, AppColors.mint),
            _bar(1, 6.8, AppColors.mint),
            _bar(2, 5.1, AppColors.lime),
            _bar(3, 8.4, AppColors.lime),
            _bar(4, 7.2, AppColors.mint),
            _bar(5, 9.0, AppColors.lime),
          ],
        ),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
      ),
    );
  }

  static BarChartGroupData _bar(int x, double value, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 16,
          borderRadius: BorderRadius.circular(7),
        ),
      ],
    );
  }
}
