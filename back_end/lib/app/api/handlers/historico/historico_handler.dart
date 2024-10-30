part of api;

class GetHistoricoHandler implements Handler {
  final HistoricoUseCase historicoUseCase;
  GetHistoricoHandler({
    required this.historicoUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicoUseCase.get(
        requestParams: requestParams,
      );
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

class PostHistoricosHandler implements Handler {
  final HistoricoUseCase historioUseCase;
  PostHistoricosHandler({
    required this.historioUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          (requestParams.body!['idAplicacao'] == null ||
                  requestParams.body!['fonte'] == null ||
                  requestParams.body!['descricao'] == null ||
                  requestParams.body!['idAplicacao'].toString().isEmpty ||
                  requestParams.body!['fonte'].toString().isEmpty ||
                  requestParams.body!['descricao'].toString().isEmpty) &&
              requestParams.body!['formdata'] == null) {
        throw FieldsIsEmpty();
      }
      final result = await historioUseCase.create(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Criado com sucesso !!'}
            : {'mensagem': 'Houve um error ao criar o histórico !!'},
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

class PutHistoricoHandler implements Handler {
  final HistoricoUseCase historicoUseCase;
  PutHistoricoHandler({
    required this.historicoUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicoUseCase.update(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Atualizado com sucesso !!'}
            : {'mensagem': 'Houve um error ao atualizar o histórico !!'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {
          'mensagem': e.toString(),
          'stackTrace': s.toString(),
        },
      );
    }
  }
}

class DeleteHistoricoHandler implements Handler {
  final HistoricoUseCase historicoUseCase;
  DeleteHistoricoHandler({
    required this.historicoUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicoUseCase.delete(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Historico deletado com sucesso !!'}
            : {'mensagem': 'Houve um error ao deletar o histórico !!'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {
          'mensagem': e.toString(),
          'stackTrace': s.toString(),
        },
      );
    }
  }
}

class DeleteFileHistoricoHandler implements Handler {
  final HistoricoUseCase historicoUseCase;
  DeleteFileHistoricoHandler({
    required this.historicoUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicoUseCase.deleteFile(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Arquivo deletado com sucesso !!'}
            : {'mensagem': 'Houve um error ao deletar o arquivo !!'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {
          'mensagem': e.toString(),
          'stackTrace': s.toString(),
        },
      );
    }
  }
}

class UploadFileHistoricosHandler implements Handler {
  final HistoricoUseCase historicoUseCase;
  UploadFileHistoricosHandler({
    required this.historicoUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicoUseCase.uploadFile(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Arquivo salvo com sucesso !!'}
            : {'mensagem': 'Houve um error ao salvar o arquivo !!'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {
          'mensagem': e.toString(),
          'stackTrace': s.toString(),
        },
      );
    }
  }
}

class GetDownloadFileHistoricoHandler implements Handler {
  final HistoricoUseCase historicoUseCase;
  GetDownloadFileHistoricoHandler({
    required this.historicoUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final data = await historicoUseCase.downloadFile(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: data,
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {
          'mensagem': e.toString(),
          'stackTrace': s.toString(),
        },
      );
    }
  }
}
