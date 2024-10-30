import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/gateways/dashboard/dashboard_gateway.dart';
import 'package:back_end/app/data/services/dashboard/dashboard_service.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/dao/dashboard/dashboard_dao.dart';
import 'package:get_it/get_it.dart';

void injectDashboard(GetIt getIt) {
  getIt
    ..registerLazySingleton<DashboardGateway>(
      () => DashboardDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<DashboardUseCase>(
      () => DashboardService(dashboardGateway: getIt()),
    )
    ..registerLazySingleton<DashboardController>(
      () => DashboardController(
        dashBoardUseCase: getIt(),
      ),
    );
}
