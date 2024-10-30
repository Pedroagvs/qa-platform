import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/externals/service/anexar_arquivos.dart';

void injectAnexarArquivoService(GetIt getIt) {
  getIt.registerLazySingleton<AnexarArquivosService>(
    AnexarArquivosService.new,
  );
}
