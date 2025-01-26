part of config;

final authController = getIt.get<AuthController>();
final aplicacaoController = getIt.get<AplicationController>();
final historicoController = getIt.get<HistoricController>();
final testeController = getIt.get<TesteController>();
final userController = getIt.get<UserController>();
final dashboardController = getIt.get<DashboardController>();
final controllers = <Controller>[
  authController,
  aplicacaoController,
  historicoController,
  testeController,
  dashboardController,
  userController,
];
