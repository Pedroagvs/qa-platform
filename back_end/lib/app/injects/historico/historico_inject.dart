import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectHistorico(GetIt getIt) {
  getIt
    ..registerFactory<HistoricGateway>(
      () => HistoricoDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<HistoricoUseCase>(
      () => HistoricoService(
        historicoGateway: getIt(),
        testeGateWay: getIt(),
      ),
    )
    ..registerLazySingleton<HistoricoController>(
      () => HistoricoController(
        historicoUseCase: getIt(),
      ),
    );
}
