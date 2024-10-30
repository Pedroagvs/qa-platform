import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/legend_widget.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> dotshistoricoAbertos;
  final List<FlSpot> dotshistoricoFechados;
  final List<FlSpot> dotstestesFechados;
  final List<FlSpot> dotstestesAbertos;
  final List<FlSpot> dotstotalHistoricos;
  const LineChartWidget({
    super.key,
    required this.dotshistoricoAbertos,
    required this.dotshistoricoFechados,
    required this.dotstestesFechados,
    required this.dotstestesAbertos,
    required this.dotstotalHistoricos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.2,
          width: MediaQuery.sizeOf(context).width * 0.5,
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
                  spots: dotshistoricoAbertos,
                  color: Colors.red,
                  isCurved: true,
                ),
                LineChartBarData(
                  spots: dotshistoricoFechados,
                  color: Colors.green,
                ),
                LineChartBarData(
                  spots: dotstestesFechados,
                  color: Colors.orange,
                ),
                LineChartBarData(
                  spots: dotstestesAbertos,
                  color: Colors.blue,
                ),
                LineChartBarData(
                  spots: dotstotalHistoricos,
                  color: Colors.pink,
                ),
              ],
            ),
          ),
        ),
        const LegendWidget(
          color: Colors.red,
          label: 'Históricos abertos',
        ),
        const LegendWidget(
          color: Colors.green,
          label: 'Históricos fechados',
        ),
        const LegendWidget(
          color: Colors.orange,
          label: 'Testes fechados',
        ),
        const LegendWidget(
          color: Colors.blue,
          label: 'Testes abertos',
        ),
        const LegendWidget(
          color: Colors.pink,
          label: 'Total de históricos',
        ),
      ],
    );
  }
}
