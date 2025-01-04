import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectAplicacao(GetIt getIt) {
  getIt
    ..registerLazySingleton<AplicacaoGateway>(
      () => AplicacaoDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<AplicacaoUseCase>(
      () => AplicacaoService(
        aplicacaoGateway: getIt(),
      ),
    )
    ..registerLazySingleton<AplicacaoHandler>(
      () => AplicacaoHandler(
        create: PostAplicacaoHandler(aplicacaoUseCase: getIt()),
        delete: DeleteAplicacoesHandler(aplicacaoUseCase: getIt()),
        read: GetAplicacoesHandler(aplicacaoUseCase: getIt()),
        update: PutAplicacaoHandler(aplicacaoUseCase: getIt()),
      ),
    )
    ..registerLazySingleton<AplicacaoController>(
      () => AplicacaoController(
        aplicacaoUseCase: getIt(),
        aplicacaoHandler: getIt(),
      ),
    );
}
