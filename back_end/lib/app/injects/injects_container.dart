import 'package:back_end/app/infra/infra.dart';
import 'package:back_end/app/injects/aplicacoes/aplicacao_inject.dart';
import 'package:back_end/app/injects/auth/auth_inject.dart';
import 'package:back_end/app/injects/dashboard/dashboard_inject.dart';
import 'package:back_end/app/injects/historico/historico_inject.dart';
import 'package:back_end/app/injects/teste/teste_inject.dart';
import 'package:back_end/app/injects/user/get_user_by_email_inject.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
Future<void> injectInit() async {
  getIt.registerSingleton<Connection>(MySQl());
  injectAuth(getIt);
  injectUser(getIt);
  injectAplicacao(getIt);
  injectHistorico(getIt);
  injectTeste(getIt);
  injectDashboard(getIt);
}
