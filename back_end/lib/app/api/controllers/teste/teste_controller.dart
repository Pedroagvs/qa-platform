part of api;

class TesteController implements Controller {
  final TesteHandler testeHandler;
  TesteController({required this.testeHandler});
  @override
  String get route => '/teste';

  @override
  Map<String, Handler> get handler => {
        'POST': testeHandler.create,
        'POST /arquivos': testeHandler.createFile,
        'PUT': testeHandler.update,
        'GET': testeHandler.read,
        'GET /arquivos': testeHandler.getFile,
        'DELETE': testeHandler.delete,
        'DELETE /arquivos': testeHandler.deleteFile,
      };
}
