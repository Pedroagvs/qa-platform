part of api;

class HistoricoController implements Controller {
  final HistoricoUseCase historicoUseCase;
  HistoricoController({
    required this.historicoUseCase,
  });
  @override
  String get route => '/historico';

  @override
  Map<String, Handler> get handler => {
        'GET': GetHistoricoHandler(
          historicoUseCase: historicoUseCase,
        ),
        'GET /downloadFile': GetDownloadFileHistoricoHandler(
          historicoUseCase: historicoUseCase,
        ),
        'POST': PostHistoricosHandler(
          historioUseCase: historicoUseCase,
        ),
        'POST /uploadFile': UploadFileHistoricosHandler(
          historicoUseCase: historicoUseCase,
        ),
        'PUT': PutHistoricoHandler(
          historicoUseCase: historicoUseCase,
        ),
        'DELETE': DeleteHistoricoHandler(
          historicoUseCase: historicoUseCase,
        ),
        'DELETE /deleteFile': DeleteFileHistoricoHandler(
          historicoUseCase: historicoUseCase,
        ),
      };
}
