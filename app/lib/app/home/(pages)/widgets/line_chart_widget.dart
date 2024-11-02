import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/legend_widget.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> dotsTotalTestes;
  final List<FlSpot> dotsTotalHistoricos;
  const LineChartWidget({
    super.key,
    required this.dotsTotalTestes,
    required this.dotsTotalHistoricos,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: [
        const Text('Acompanhamento'),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (dot, titleMeta) {
                      return Text(
                        DateFormat('dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            dot.toInt() * 1000,
                          ),
                        ),
                        style: const TextStyle(),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: dotsTotalHistoricos,
                  color: Colors.purple,
                  isCurved: true,
                ),
                LineChartBarData(
                  spots: dotsTotalTestes,
                  color: Colors.yellow,
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
