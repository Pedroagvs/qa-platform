part of api;

class HistoricController implements Controller {
  final HistoricHandler historicHandler;

  HistoricController({
    required this.historicHandler,
  });
  @override
  String get route => '/historico';

  @override
  Map<String, Handler> get handler => {
        'GET': historicHandler.read,
        'GET /downloadFile': historicHandler.getFile,
        'POST': historicHandler.create,
        'POST /uploadFile': historicHandler.createFile,
        'PUT': historicHandler.update,
        'DELETE': historicHandler.delete,
        'DELETE /deleteFile': historicHandler.deleteFile,
      };
}
