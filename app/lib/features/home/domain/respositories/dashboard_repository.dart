import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';

abstract class DashboardRepository {
  Future<({Failure? failure, List<DashboardEntity>? dashboard})> call({
    required String dataInicial,
    required String dataFinal,
  });
}
