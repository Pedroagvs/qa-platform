import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/core/common/data/datasource/imp/users_datasource_imp.dart';
import 'package:quality_assurance_platform/core/common/data/datasource/interface/users_datasource.dart';
import 'package:quality_assurance_platform/core/common/data/repositories/users_repository_imp.dart';
import 'package:quality_assurance_platform/core/common/domain/repositories/users_repository.dart';
import 'package:quality_assurance_platform/core/common/domain/usecases/imp/users_usecase_imp.dart';
import 'package:quality_assurance_platform/core/common/domain/usecases/interface/users_usecase.dart';

void injectUsers(GetIt getIt) {
  getIt
    ..registerLazySingleton<UsersDataSource>(
      () => UsersDataSourceImp(getIt()),
    )
    ..registerLazySingleton<UsersRepository>(() => UsersRepositoryImp(getIt()))
    ..registerLazySingleton<UsersUseCase>(() => UsersUseCaseImp(getIt()));
}
