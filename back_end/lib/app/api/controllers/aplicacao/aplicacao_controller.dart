part of api;

class AplicacaoController implements Controller {
  final AplicacaoUseCase aplicacaoUseCase;

  AplicacaoController({
    required this.aplicacaoUseCase,
  });
  @override
  String get route => '/aplicacao';

  @override
  Map<String, Handler> get handler => {
        'GET': GetAplicacoesHandler(aplicacaoUseCase: aplicacaoUseCase),
        'POST': PostAplicacaoHandler(aplicacaoUseCase: aplicacaoUseCase),
        'PUT': PutAplicacaoHandler(aplicacaoUseCase: aplicacaoUseCase),
        'DELETE': DeleteAplicacoesHandler(
          aplicacaoUseCase: aplicacaoUseCase,
        ),
      };
}
