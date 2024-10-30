import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/core/inject/inject_users.dart';
import 'package:quality_assurance_platform/core/inject/services/inject_uno_client.dart';
import 'package:quality_assurance_platform/features/historico/inject/inject_historico.dart';
import 'package:quality_assurance_platform/features/home/inject/inject_home.dart';
import 'package:quality_assurance_platform/features/login/inject/inject_login.dart';
import 'package:quality_assurance_platform/features/testes/inject/inject_testes.dart';

import 'services/anexar_arquivos.dart';

void injectContainer(GetIt getIt) {
  injectUsers(getIt);
  injectUnoClient(getIt);
  injectAnexarArquivoService(getIt);
  injectLogin(getIt);
  initHome(getIt);
  initInjectHistoricoDosGruposDeTestesPorAplicacao(getIt);
  initInjectHistoricoDosTestesDeUmGrupo(getIt);
}
