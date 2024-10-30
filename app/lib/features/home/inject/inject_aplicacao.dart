import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/imp/aplicacoes_datasource_imp.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/interface/aplicacoes_datasource.dart';
import 'package:quality_assurance_platform/features/home/data/repositories/aplicacoes_repository_imp.dart';
import 'package:quality_assurance_platform/features/home/domain/respositories/aplicacoes_repository.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/imp/aplicacoes_usecase_imp.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/interface/aplicacoes_usecase.dart';

void injectAplicacao(GetIt getIt) {
  getIt
    ..registerLazySingleton<ApplicationDataSource>(
      () => ApplicationDataSourceImp(unoClient: getIt()),
    )
    ..registerLazySingleton<ApplicationRepository>(
      () => ApplicationRepositoryImp(getIt()),
    )
    ..registerLazySingleton<ApplicationUseCase>(
      () => ApplicationUseCaseImp(getIt()),
    );
}
