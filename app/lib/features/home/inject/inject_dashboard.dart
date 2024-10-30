import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/imp/dashboard_datasource_imp.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/interface/dashboard_datasource.dart';
import 'package:quality_assurance_platform/features/home/data/repositories/dashboard_repository_imp.dart';
import 'package:quality_assurance_platform/features/home/domain/respositories/dashboard_repository.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/imp/dashboard_usecase_imp.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/interface/dashboard_usecase.dart';

void injectDashboard(GetIt getIt) {
  getIt
    ..registerLazySingleton<DashboardDataSource>(
      () => DashboardDataSourceImp(unoClient: getIt()),
    )
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImp(getIt()),
    )
    ..registerLazySingleton<DashboardUseCase>(
      () => DashboardUseCaseImp(getIt()),
    );
}
