part of api;

class AplicacaoHandler {
  final Handler read;
  final Handler create;
  final Handler delete;
  final Handler update;

  AplicacaoHandler({
    required this.create,
    required this.delete,
    required this.read,
    required this.update,
  });
}

class GetAplicacoesHandler implements Handler {
  final AplicacaoUseCase aplicacaoUseCase;
  GetAplicacoesHandler({required this.aplicacaoUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final applications = await aplicacaoUseCase.get();
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: applications,
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class PostAplicacaoHandler implements Handler {
  final AplicacaoUseCase aplicacaoUseCase;
  PostAplicacaoHandler({required this.aplicacaoUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['titulo'] == null ||
          requestParams.body!['plataforma'] == null ||
          requestParams.body!['titulo'].toString().isEmpty ||
          requestParams.body!['plataforma'].toString().isEmpty) {
        throw FieldsIsEmpty();
      }
      final result =
          await aplicacaoUseCase.create(requestParams: requestParams);

      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.internalError,
        body: result
            ? {'mensagem': 'Aplicação criada com sucesso !!'}
            : {'mensagem': 'Falha ao criar a aplicação.'},
      );
    } on ExistsApplication {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'Já existe uma aplicação com este título.'},
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'Os campos são obrigatórios.'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class DeleteAplicacoesHandler implements Handler {
  final AplicacaoUseCase aplicacaoUseCase;

  DeleteAplicacoesHandler({
    required this.aplicacaoUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['idAplicacao'] == null ||
          requestParams.body!['idAplicacao'].toString().isEmpty) {
        throw FieldsIsEmpty();
      }
      final result =
          await aplicacaoUseCase.delete(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.internalError,
        body: result
            ? {'mensagem': 'Aplicação deletada com sucesso !!'}
            : {'mensagem': 'Falha ao deletar a aplicação.'},
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'O id da aplicação é obrigatório.'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class PutAplicacaoHandler implements Handler {
  final AplicacaoUseCase aplicacaoUseCase;
  PutAplicacaoHandler({required this.aplicacaoUseCase});
  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['idAplicacao'] == null ||
          (requestParams.body!['titulo'] == null &&
              requestParams.body!['plataforma'] == null) ||
          (requestParams.body!['titulo'].toString().isEmpty &&
              requestParams.body!['plataforma'].toString().isEmpty)) {
        throw FieldsIsEmpty();
      }
      final result =
          await aplicacaoUseCase.update(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.internalError,
        body: result
            ? {'mensagem': 'Aplicação editada com sucesso !!'}
            : {'mensagem': 'Falha ao editar a Aplicação.'},
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'O id da aplicação é obrigatório.'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}
