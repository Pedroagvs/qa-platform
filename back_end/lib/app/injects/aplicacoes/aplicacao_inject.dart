import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectAplicacao(GetIt getIt) {
  getIt
    ..registerFactory<AplicacaoGateway>(
      () => AplicacaoDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<AplicacaoUseCase>(
      () => AplicacaoService(
        aplicacaoGateway: getIt(),
      ),
    )
    ..registerLazySingleton<AplicacaoController>(
      () => AplicacaoController(
        aplicacaoUseCase: getIt(),
      ),
    );
}
