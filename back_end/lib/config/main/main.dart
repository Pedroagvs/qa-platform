part of config;

final authController = getIt.get<AuthController>();
final registerController = getIt.get<RegisterController>();
final aplicacaoController = getIt.get<AplicacaoController>();
final historicoController = getIt.get<HistoricoController>();
final testeController = getIt.get<TesteController>();
final userController = getIt.get<UserController>();
final dashboardController = getIt.get<DashboardController>();
final controllers = <Controller>[
  authController,
  registerController,
  aplicacaoController,
  historicoController,
  testeController,
  dashboardController,
  userController,
];
