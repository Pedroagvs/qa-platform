import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/interface/dashboard_datasource.dart';
import 'package:quality_assurance_platform/features/home/domain/respositories/dashboard_repository.dart';

class DashboardRepositoryImp implements DashboardRepository {
  final DashboardDataSource dashboardDataSource;
  DashboardRepositoryImp(this.dashboardDataSource);
  @override
  Future<({List<DashboardEntity>? dashboard, Failure? failure})> call({
    required String dataInicial,
    required String dataFinal,
  }) async {
    try {
      return (
        failure: null,
        dashboard: await dashboardDataSource(
          dataFinal: dataFinal,
          dataInicial: dataInicial,
        )
      );
    } on Failure catch (e) {
      return (failure: e, dashboard: null);
    }
  }
}
