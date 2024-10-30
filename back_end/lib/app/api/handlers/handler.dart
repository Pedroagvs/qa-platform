part of api;

class ResponseHandler {
  final StatusHandler statusHandler;
  final Object body;

  ResponseHandler({
    required this.statusHandler,
    required this.body,
  });
}

abstract class Handler {
  Future<ResponseHandler> call({required RequestParams requestParams});
}

class RequestParams {
  Map<String, dynamic>? body;
  RequestParams({required this.body});
}

enum StatusHandler {
  ok,
  internalError,
  badRequest,
  forbidden,
  created,
}
