part of api;

class DashboardController implements Controller {
  final DashboardUseCase dashBoardUseCase;
  DashboardController({
    required this.dashBoardUseCase,
  });
  @override
  String get route => '/dashboard';

  @override
  Map<String, Handler> get handler => {
        'GET': GetDashboardHandler(
          dashboardUseCase: dashBoardUseCase,
        ),
      };
}
