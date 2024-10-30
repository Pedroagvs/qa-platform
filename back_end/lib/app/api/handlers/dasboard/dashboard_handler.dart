part of api;

class GetDashboardHandler implements Handler {
  final DashboardUseCase dashboardUseCase;
  GetDashboardHandler({required this.dashboardUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await dashboardUseCase.call(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: result,
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}
