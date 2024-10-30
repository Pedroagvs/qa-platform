part of api;

class TesteController implements Controller {
  final TesteUseCase testeUseCase;
  TesteController({required this.testeUseCase});
  @override
  String get route => '/teste';

  @override
  Map<String, Handler> get handler => {
        'POST': PostTesteHandler(
          testeUseCase: testeUseCase,
        ),
        'POST /arquivos': PostEnviarArquivoTesteHandler(
          testeUseCase: testeUseCase,
        ),
        'PUT': PutTesteHandler(
          testeUseCase: testeUseCase,
        ),
        'GET': GetTesteHandler(
          testeUseCase: testeUseCase,
        ),
        'GET /arquivos': GetBuscarArquivoTesteHandler(
          testeUseCase: testeUseCase,
        ),
        'DELETE': DeleteTesteHandler(
          testeUseCase: testeUseCase,
        ),
        'DELETE /arquivos': DeleteArquivoTesteHandler(
          testeUseCase: testeUseCase,
        ),
      };
}
