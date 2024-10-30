import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';

class DashboardState {
  final StatusDashbord statusDashbord;
  final List<DashboardEntity> dashboardData;
  final String finalDate;
  final String initialDate;
  DashboardState({
    required this.statusDashbord,
    required this.dashboardData,
    this.finalDate = '',
    this.initialDate = '',
  });
}

enum StatusDashbord {
  initial,
  loading,
  loaded,
}
