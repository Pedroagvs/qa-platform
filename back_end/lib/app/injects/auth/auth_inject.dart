import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:get_it/get_it.dart';

void injectAuth(GetIt getIt) {
  getIt
    ..registerLazySingleton<AuthGateway>(
      () => AuthDAO(
        connection: getIt(),
      ),
    )
    ..registerLazySingleton<AuthUseCase>(
      () => AuthService(authGateway: getIt()),
    )
    ..registerLazySingleton<AuthController>(
      () => AuthController(
        authUseCase: getIt(),
      ),
    );
}
