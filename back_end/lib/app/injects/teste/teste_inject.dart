import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectTeste(GetIt getIt) {
  getIt
    ..registerFactory<TesteGateWay>(
      () => TesteDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<TesteUseCase>(
      () => TesteService(
        testeGateWay: getIt(),
      ),
    )
    ..registerLazySingleton<TesteController>(
      () => TesteController(
        testeUseCase: getIt(),
      ),
    );
}
