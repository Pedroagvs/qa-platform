import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/features/login/data/datasources/remote/imp/auth_datasource_imp.dart';
import 'package:quality_assurance_platform/features/login/data/datasources/remote/interface/auth_datasource.dart';
import 'package:quality_assurance_platform/features/login/data/repositories/auth/auth_repository_imp.dart';
import 'package:quality_assurance_platform/features/login/domain/repositories/auth_repository.dart';
import 'package:quality_assurance_platform/features/login/domain/usecases/imp/auth_usecase_imp.dart';
import 'package:quality_assurance_platform/features/login/domain/usecases/interface/auth_usecase.dart';

void injectLogin(GetIt getIt) {
  getIt
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImp(unoClient: getIt()),
    )
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(getIt()))
    ..registerLazySingleton<AuthUseCase>(() => AuthUseCaseImp(getIt()));
}
