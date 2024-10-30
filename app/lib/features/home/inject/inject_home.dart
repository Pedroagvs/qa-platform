import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/features/home/inject/inject_aplicacao.dart';
import 'package:quality_assurance_platform/features/home/inject/inject_dashboard.dart';

void initHome(GetIt getIt) {
  injectAplicacao(getIt);
  injectDashboard(getIt);
}
