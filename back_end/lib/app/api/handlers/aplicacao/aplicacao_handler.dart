part of api;

class AplicationHandler {
  final Handler read;
  final Handler create;
  final Handler delete;
  final Handler update;

  AplicationHandler({
    required this.create,
    required this.delete,
    required this.read,
    required this.update,
  });
}

class GetApplicationsHandler implements Handler {
  final AplicationUseCase aplicacaoUseCase;
  GetApplicationsHandler({required this.aplicacaoUseCase});

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

class CreateAplicationHandler implements Handler {
  final AplicationUseCase aplicationUseCase;
  CreateAplicationHandler({required this.aplicationUseCase});

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
          await aplicationUseCase.create(requestParams: requestParams);

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

class DeleteAplicationHandler implements Handler {
  final AplicationUseCase aplicationUseCase;
  DeleteAplicationHandler({
    required this.aplicationUseCase,
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
          await aplicationUseCase.delete(requestParams: requestParams);
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

class UpdateAplicationHandler implements Handler {
  final AplicationUseCase aplicationUseCase;
  UpdateAplicationHandler({required this.aplicationUseCase});
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
          await aplicationUseCase.update(requestParams: requestParams);
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
