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
    final availableHeight =
        MediaQuery.of(context).size.height - (AppBar().preferredSize.height);
    final dashboardState = useAtomState(stateDahboard);

    final dotsHistoricoAbertos = <FlSpot>[];
    final dotsHistoricoFechados = <FlSpot>[];
    final dotsTestesAbertos = <FlSpot>[];
    final dotsTestesFechados = <FlSpot>[];
    final dotsTotalHistoricos = <FlSpot>[];
    final dotsTotalTestes = <FlSpot>[];
    for (final dash in dashboardState.dashboardData) {
      dash.data.forEach((date, data) {
        data.forEach((tipo, value) {
          if (tipo == 'historicoAbertos') {
            dotsHistoricoAbertos.add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'historicoFechados') {
            dotsHistoricoFechados
                .add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'testesFechados') {
            dotsTestesFechados.add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'testesAbertos') {
            dotsTestesAbertos.add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'totalHistoricos') {
            dotsTotalHistoricos.add(FlSpot(date.toDouble(), value.toDouble()));
          }
          if (tipo == 'totalTestes') {
            dotsTotalTestes.add(FlSpot(date.toDouble(), value.toDouble()));
          }
        });
      });
    }

    return SizedBox(
      height: availableHeight,
      width: MediaQuery.sizeOf(context).width,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${dashboardState.initialDate} á ${dashboardState.finalDate}',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.calendar_month_outlined,
              ),
              label: const Text('Filtrar'),
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
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: MediaQuery.sizeOf(context).width * 0.9,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: LineChartWidget(
                    dotsTotalHistoricos: dotsTotalHistoricos,
                    dotsTotalTestes: dotsTotalTestes,
                  ),
                ),
              ),
            ),
            Wrap(
              children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 400, minHeight: 220),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Testes'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: SizedBox(
                                  width: 250,
                                  height: 160,
                                  child: PieChart(
                                    PieChartData(
                                      sections: [
                                        PieChartSectionData(
                                          color: Colors.blue,
                                          value: dotsTestesAbertos.fold<double>(
                                            0,
                                            (e, k) => e + k.y,
                                          ),
                                        ),
                                        PieChartSectionData(
                                          color: Colors.orange,
                                          value:
                                              dotsTestesFechados.fold<double>(
                                            0,
                                            (e, k) => e + k.y,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LegendWidget(
                                color: Colors.orange,
                                label: 'Testes fechados',
                              ),
                              LegendWidget(
                                color: Colors.blue,
                                label: 'Testes abertos',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 400, minHeight: 220),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Wrap(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Históricos'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: SizedBox(
                                  width: 250,
                                  height: 160,
                                  child: PieChart(
                                    PieChartData(
                                      sections: [
                                        PieChartSectionData(
                                          color: Colors.red,
                                          value:
                                              dotsHistoricoAbertos.fold<double>(
                                            0,
                                            (e, k) => e + k.y,
                                          ),
                                        ),
                                        PieChartSectionData(
                                          color: Colors.green,
                                          value: dotsHistoricoFechados
                                              .fold<double>(
                                            0,
                                            (e, k) => e + k.y,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LegendWidget(
                                color: Colors.red,
                                label: 'Históricos abertos',
                              ),
                              LegendWidget(
                                color: Colors.green,
                                label: 'Históricos fechados',
                              ),
                            ],
                          ),
                        ],
                      ),
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
