part of api;

class AplicacaoController implements Controller {
  final AplicacaoUseCase aplicacaoUseCase;
  final AplicacaoHandler aplicacaoHandler;
  AplicacaoController({
    required this.aplicacaoUseCase,
    required this.aplicacaoHandler,
  });
  @override
  String get route => '/aplicacao';

  @override
  Map<String, Handler> get handler => {
        'GET': aplicacaoHandler.read,
        'POST': aplicacaoHandler.create,
        'PUT': aplicacaoHandler.update,
        'DELETE': aplicacaoHandler.delete,
      };
}
