import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/home/domain/respositories/dashboard_repository.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/interface/dashboard_usecase.dart';

class DashboardUseCaseImp implements DashboardUseCase {
  final DashboardRepository _dashboardRepository;
  DashboardUseCaseImp(this._dashboardRepository);
  @override
  Future<({Failure? failure, List<DashboardEntity>? dashboard})> call({
    required String dataInicial,
    required String dataFinal,
  }) {
    return _dashboardRepository.call(
      dataInicial: dataInicial,
      dataFinal: dataFinal,
    );
  }
}
