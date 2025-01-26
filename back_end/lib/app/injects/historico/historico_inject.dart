import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectHistorico(GetIt getIt) {
  getIt
    ..registerLazySingleton<HistoricGateway>(
      () => HistoricDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<HistoricUseCase>(
      () => HistoricService(
        historicGateway: getIt(),
        testGateWay: getIt(),
      ),
    )
    ..registerLazySingleton<HistoricHandler>(
      () => HistoricHandler(
        create: CreateHistoricHandler(historicUseCase: getIt()),
        read: GetHistoricHandler(historicUseCase: getIt()),
        update: UpdateHistoricHandler(historicUseCase: getIt()),
        delete: DeleteHistoricHandler(historicUseCase: getIt()),
        getFile: GetFileHistoricHandler(historicUseCase: getIt()),
        createFile: CreateFileHistoricHandler(historicUseCase: getIt()),
        deleteFile: DeleteFileHistoricHandler(historicUseCase: getIt()),
      ),
    )
    ..registerLazySingleton<HistoricController>(
      () => HistoricController(
        historicHandler: getIt(),
      ),
    );
}
