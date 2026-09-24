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

class SignalVisual extends StatelessWidget {
  const SignalVisual({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 18),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: 8,
          minY: 0,
          maxY: 10,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            horizontalInterval: 2,
            verticalInterval: 2,
            getDrawingHorizontalLine: (_) => const FlLine(color: AppColors.line, strokeWidth: 1),
            getDrawingVerticalLine: (_) => const FlLine(color: AppColors.line, strokeWidth: 1),
          ),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3.2),
                FlSpot(1, 4.1),
                FlSpot(2, 3.7),
                FlSpot(3, 6.2),
                FlSpot(4, 5.4),
                FlSpot(5, 7.1),
                FlSpot(6, 6.4),
                FlSpot(7, 8.2),
                FlSpot(8, 7.7),
              ],
              isCurved: true,
              preventCurveOverShooting: true,
              gradient: const LinearGradient(colors: [AppColors.coral, AppColors.lime]),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.coral.withValues(alpha: .18), AppColors.coral.withValues(alpha: 0)],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
      ),
    );
  }
}
