import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectUser(GetIt getIt) {
  getIt
    ..registerFactory<UserGateway>(
      () => UserDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<UserUseCase>(
      () => UserService(
        userGateway: getIt(),
      ),
    )
    ..registerLazySingleton<UserController>(
      () => UserController(
        userUseCase: getIt(),
      ),
    );
}