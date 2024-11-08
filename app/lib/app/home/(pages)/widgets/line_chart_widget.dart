import 'package:asp/asp.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/legend_widget.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/dashboard_atom.dart';

class LineChartWidget extends StatelessWidget with HookMixin {
  final List<FlSpot> dotsTotalTestes;
  final List<FlSpot> dotsTotalHistoricos;
  const LineChartWidget({
    super.key,
    required this.dotsTotalTestes,
    required this.dotsTotalHistoricos,
  });

  @override
  Widget build(BuildContext context) {
    final dashboardState = useAtomState(stateDahboard);
    final minX = (DateTime.tryParse(dashboardState.initialDate)
                ?.millisecondsSinceEpoch
                .toDouble() ??
            0) /
        1000.0;
    final maxX = (DateTime.tryParse(dashboardState.finalDate)
                ?.millisecondsSinceEpoch
                .toDouble() ??
            0) /
        1000;
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: [
        const Text('Acompanhamento'),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: LineChart(
            LineChartData(
              lineTouchData: const LineTouchData(enabled: false),
              gridData: const FlGridData(
                drawVerticalLine: false,
                verticalInterval: 1,
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: (maxX / minX) * 100000,
                    getTitlesWidget: (dot, titleMeta) {
                      return SideTitleWidget(
                        space: 4,
                        axisSide: titleMeta.axisSide,
                        child: Text(
                          DateFormat('dd').format(
                            DateTime.fromMillisecondsSinceEpoch(
                              dot.toInt() * 1000,
                            ),
                          ),
                          style: const TextStyle(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              minX: minX,
              minY: 0,
              maxX: maxX,
              lineBarsData: [
                LineChartBarData(
                  preventCurveOverShooting: true,
                  curveSmoothness: 0.05,
                  spots: dotsTotalHistoricos,
                  color: Colors.purple,
                  isCurved: true,
                ),
                LineChartBarData(
                  preventCurveOverShooting: true,
                  preventCurveOvershootingThreshold: 100,
                  curveSmoothness: 0.05,
                  spots: dotsTotalTestes,
                  color: Colors.yellow,
                  isCurved: true,
                ),
              ],
            ),
          ),
        ),
        const Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            LegendWidget(
              color: Colors.yellow,
              label: 'Total de testes',
            ),
            LegendWidget(
              color: Colors.purple,
              label: 'Total de históricos',
            ),
          ],
        ),
      ],
    );
  }
}
