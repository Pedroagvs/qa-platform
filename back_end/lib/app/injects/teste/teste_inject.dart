import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectTeste(GetIt getIt) {
  getIt
    ..registerLazySingleton<TestGateWay>(
      () => TestDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<TestUseCase>(
      () => TestService(
        testGateWay: getIt(),
      ),
    )
    ..registerLazySingleton<TesteHandler>(
      () => TesteHandler(
        create: CreateTestHandler(testUseCase: getIt()),
        delete: DeleteTestHandler(testUseCase: getIt()),
        read: GetTestHandler(testUseCase: getIt()),
        update: UpdateTestHandler(testUseCase: getIt()),
        createFile: UploadFileTestHandler(testUseCase: getIt()),
        getFile: GetFilesTestHandler(testUseCase: getIt()),
        deleteFile: DeleteFileTestHandler(testUseCase: getIt()),
      ),
    )
    ..registerLazySingleton<TesteController>(
      () => TesteController(
        testeHandler: getIt(),
      ),
    );
}
