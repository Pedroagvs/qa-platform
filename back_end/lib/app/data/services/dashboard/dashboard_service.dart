import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/dashboard_dto.dart';
import 'package:back_end/app/data/gateways/dashboard/dashboard_gateway.dart';
import 'package:back_end/app/domain/domain.dart';

class DashboardService implements DashboardUseCase {
  final DashboardGateway dashboardGateway;
  DashboardService({
    required this.dashboardGateway,
  });
  @override
  Future<List<DashboardDto>> call({
    required RequestParams requestParams,
  }) async =>
      dashboardGateway(requestParams: requestParams);
}
