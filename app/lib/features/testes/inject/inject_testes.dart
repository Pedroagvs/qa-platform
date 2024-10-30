import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/features/testes/data/imp/teste_datesource_imp.dart';
import 'package:quality_assurance_platform/features/testes/data/interface/teste_datasource.dart';
import 'package:quality_assurance_platform/features/testes/data/repository/teste_repository_imp.dart';
import 'package:quality_assurance_platform/features/testes/domain/repository/teste_repository.dart';
import 'package:quality_assurance_platform/features/testes/domain/usecase/imp/teste_usecase_imp.dart';
import 'package:quality_assurance_platform/features/testes/domain/usecase/interface/teste_usecase.dart';

void initInjectHistoricoDosTestesDeUmGrupo(GetIt getIt) {
  getIt
    ..registerLazySingleton<TesteDataSource>(
      () => TesteDataSourceImp(
        unoClient: getIt(),
      ),
    )
    ..registerLazySingleton<TesteRepository>(
      () => TesteRepositoryImp(testeDataSource: getIt()),
    )
    ..registerLazySingleton<TesteUseCase>(
      () => TesteUseCaseImp(testeRepository: getIt()),
    );
}
