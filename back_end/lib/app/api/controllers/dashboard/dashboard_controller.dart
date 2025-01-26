part of api;

class DashboardController implements Controller {
  final DashboardHandler dashboardHandler;
  DashboardController({
    required this.dashboardHandler,
  });
  @override
  String get route => '/dashboard';

  @override
  Map<String, Handler> get handler => {
        'GET': dashboardHandler.read,
      };
}
