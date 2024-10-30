import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/features/historico/data/datasource/imp/historico_datasource_imp.dart';
import 'package:quality_assurance_platform/features/historico/data/datasource/interface/historico_datasource.dart';
import 'package:quality_assurance_platform/features/historico/data/repositories/historico_repository_imp.dart';
import 'package:quality_assurance_platform/features/historico/domain/repositories/historico_repository.dart';
import 'package:quality_assurance_platform/features/historico/domain/usecases/imp/historico_usecase_imp.dart';
import 'package:quality_assurance_platform/features/historico/domain/usecases/interface/historico_usecase.dart';

void initInjectHistoricoDosGruposDeTestesPorAplicacao(GetIt getIt) {
  getIt
    ..registerLazySingleton<HistoricoDataSource>(
      () => HistoricoDataSourceImp(
        unoClient: getIt(),
      ),
    )
    ..registerLazySingleton<HistoricoRepository>(
      () => HistoricoRepositoryImp(getIt()),
    )
    ..registerLazySingleton<HistoricoUsecase>(
      () => HistoricoUseCaseImp(getIt()),
    );
}
