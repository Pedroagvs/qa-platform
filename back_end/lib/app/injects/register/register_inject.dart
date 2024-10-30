import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/usecases/register/register_usecase.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectRegister(GetIt getIt) {
  getIt
    ..registerLazySingleton<RegisterGateway>(
      () => RegisterDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<RegisterUseCase>(
      () => RegisterService(
        registerGateway: getIt(),
        userGateway: getIt(),
      ),
    )
    ..registerLazySingleton<RegisterController>(
      () => RegisterController(
        registerUseCase: getIt(),
      ),
    );
}
