import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';

abstract class DashboardDataSource {
  Future<List<DashboardEntity>> call({
    required String dataInicial,
    required String dataFinal,
  });
}
