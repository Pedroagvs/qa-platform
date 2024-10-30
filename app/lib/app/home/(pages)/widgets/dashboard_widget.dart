import 'package:asp/asp.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/legend_widget.dart';
import 'package:quality_assurance_platform/app/home/(pages)/widgets/line_chart_widget.dart';
import 'package:quality_assurance_platform/app/home/controller/atoms/dashboard_atom.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> with HookStateMixin {
  final dateFormat = DateFormat('yyyy-MM-dd');
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardState = useAtomState(stateDahboard);
      getDashboard(
        dashboardState.initialDate,
        dashboardState.finalDate,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            kToolbarHeight +
            AppBar().preferredSize.height);
    final dashboardState = useAtomState(stateDahboard);

    final dotshistoricoAbertos = <FlSpot>[];
    final dotshistoricoFechados = <FlSpot>[];
    final dotstestesAbertos = <FlSpot>[];
    final dotstestesFechados = <FlSpot>[];
    final dotstotalHistoricos = <FlSpot>[];
    for (final dash in dashboardState.dashboardData) {
      dash.data.forEach((date, data) {
        data.forEach((tipo, value) {
          if (tipo == 'historicoAbertos') {
            dotshistoricoAbertos.add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'historicoFechados') {
            dotshistoricoFechados
                .add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'testesFechados') {
            dotstestesFechados.add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'testesAbertos') {
            dotstestesAbertos.add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'totalHistoricos') {
            dotstotalHistoricos.add(FlSpot(date.toDouble(), value.toDouble()));
          }
        });
      });
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: availableHeight,
        width: MediaQuery.sizeOf(context).width,
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                  ),
                  label: const Text('Selecionar data'),
                  onPressed: () async {
                    final dates = await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                        calendarType: CalendarDatePicker2Type.range,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now(),
                      ),
                      dialogSize: Size(
                        MediaQuery.sizeOf(context).width * 0.5,
                        availableHeight * 0.2,
                      ),
                    );
                    if (dates != null) {
                      updateFinalDate(
                        dateFormat.format(dates.last!),
                      );
                      updateInitialDate(
                        dateFormat.format(dates.first!),
                      );
                      getDashboard(
                        dashboardState.initialDate,
                        dashboardState.finalDate,
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${dashboardState.initialDate} - ${dashboardState.finalDate}',
                    textAlign: TextAlign.center,
                  ),
                ),
                LineChartWidget(
                  dotshistoricoAbertos: dotshistoricoAbertos,
                  dotshistoricoFechados: dotshistoricoFechados,
                  dotstestesFechados: dotstestesFechados,
                  dotstestesAbertos: dotstestesAbertos,
                  dotstotalHistoricos: dotstotalHistoricos,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.blue,
                          value: dotstestesAbertos.fold<double>(
                            0,
                            (e, k) => e + k.y,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.orange,
                          value: dotstestesFechados.fold<double>(
                            0,
                            (e, k) => e + k.y,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.red,
                          value: dotshistoricoAbertos.fold<double>(
                            0,
                            (e, k) => e + k.y,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.green,
                          value: dotshistoricoFechados.fold<double>(
                            0,
                            (e, k) => e + k.y,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
