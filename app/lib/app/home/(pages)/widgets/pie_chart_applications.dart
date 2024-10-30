// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';

// class PieChartApplications extends StatefulWidget {
//   final List<DashboardEntity> dashboard;
//   const PieChartApplications({super.key, required this.dashboard});

//   @override
//   State<PieChartApplications> createState() => _PieChartApplicationsState();
// }

// class _PieChartApplicationsState extends State<PieChartApplications> {
//   int touchedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: widget.dashboard.isNotEmpty,
//       child: PieChart(
//         PieChartData(
//           pieTouchData: PieTouchData(
//             touchCallback: (FlTouchEvent event, pieTouchResponse) {
//               setState(() {
//                 if (!event.isInterestedForInteractions ||
//                     pieTouchResponse == null ||
//                     pieTouchResponse.touchedSection == null) {
//                   touchedIndex = -1;
//                   return;
//                 }
//                 touchedIndex =
//                     pieTouchResponse.touchedSection!.touchedSectionIndex;
//               });
//             },
//           ),
//           borderData: FlBorderData(
//             show: false,
//           ),
//           sectionsSpace: 0,
//           centerSpaceRadius: 40,
//           sections: widget.dashboard.indexed.map((app) {
//             final isTouched = app.$1 == touchedIndex;
//             final fontSize = isTouched ? 25.0 : 16.0;
//             final radius = isTouched ? 60.0 : 50.0;
//             const shadows = [Shadow(blurRadius: 2)];
//             return PieChartSectionData(
//               color: Color.fromRGBO(
//                 Random(0).nextInt(255),
//                 Random(0).nextInt(150),
//                 Random(0).nextInt(255),
//                 1,
//               ),
//               value: app.$2.qtdHistoricosFechados.toDouble(),
//               title: app.$2.aplicacao,
//               radius: radius,
//               titleStyle: TextStyle(
//                 fontSize: fontSize,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 shadows: shadows,
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
