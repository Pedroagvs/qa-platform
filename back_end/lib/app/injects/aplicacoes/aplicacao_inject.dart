import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectAplicacao(GetIt getIt) {
  getIt
    ..registerLazySingleton<AplicationGateway>(
      () => AplicationDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<AplicationUseCase>(
      () => AplicationService(
        aplicationGateway: getIt(),
      ),
    )
    ..registerLazySingleton<AplicationHandler>(
      () => AplicationHandler(
        create: CreateAplicationHandler(aplicationUseCase: getIt()),
        delete: DeleteAplicationHandler(aplicationUseCase: getIt()),
        read: GetApplicationsHandler(aplicacaoUseCase: getIt()),
        update: UpdateAplicationHandler(aplicationUseCase: getIt()),
      ),
    )
    ..registerLazySingleton<AplicationController>(
      () => AplicationController(
        aplicationHandler: getIt(),
      ),
    );
}
