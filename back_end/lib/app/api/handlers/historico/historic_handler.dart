part of api;

class HistoricHandler {
  final Handler create;
  final Handler read;
  final Handler update;
  final Handler delete;
  final Handler getFile;
  final Handler createFile;
  final Handler deleteFile;
  HistoricHandler({
    required this.create,
    required this.read,
    required this.update,
    required this.delete,
    required this.getFile,
    required this.createFile,
    required this.deleteFile,
  });
}

class GetHistoricHandler implements Handler {
  final HistoricUseCase historicUseCase;
  GetHistoricHandler({
    required this.historicUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final result = await historicUseCase.get(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: result,
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        body: {'mensagem': 'Os campos são obrigatórios.'},
        statusHandler: StatusHandler.badRequest,
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class CreateHistoricHandler implements Handler {
  final HistoricUseCase historicUseCase;
  CreateHistoricHandler({
    required this.historicUseCase,
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
      final result = await historicUseCase.create(
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

class UpdateHistoricHandler implements Handler {
  final HistoricUseCase historicUseCase;
  UpdateHistoricHandler({
    required this.historicUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicUseCase.update(
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

class DeleteHistoricHandler implements Handler {
  final HistoricUseCase historicUseCase;
  DeleteHistoricHandler({
    required this.historicUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final result = await historicUseCase.delete(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Historico deletado com sucesso !!'}
            : {'mensagem': 'Houve um error ao deletar o histórico !!'},
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'Os campos são obrigatórios.'},
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

class DeleteFileHistoricHandler implements Handler {
  final HistoricUseCase historicUseCase;
  DeleteFileHistoricHandler({
    required this.historicUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicUseCase.deleteFile(
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

class CreateFileHistoricHandler implements Handler {
  final HistoricUseCase historicUseCase;
  CreateFileHistoricHandler({
    required this.historicUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await historicUseCase.uploadFile(
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

class GetFileHistoricHandler implements Handler {
  final HistoricUseCase historicUseCase;
  GetFileHistoricHandler({
    required this.historicUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final data = await historicUseCase.downloadFile(
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
