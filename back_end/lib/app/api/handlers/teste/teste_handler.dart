part of api;

class GetTesteHandler implements Handler {
  final TesteUseCase testeUseCase;
  GetTesteHandler({required this.testeUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await testeUseCase.get(requestParams: requestParams);
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

class PostTesteHandler implements Handler {
  final TesteUseCase testeUseCase;
  PostTesteHandler({required this.testeUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final result = await testeUseCase.create(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.internalError,
        body: result
            ? {'mensagem': 'Sucesso ao criar o ticket de teste.'}
            : {'mensagem': 'Houveu um error ao criar o ticket de teste.'},
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        body: {'mensagem': 'Os campos title e aplicacao são obrigatórios.'},
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

class PostEnviarArquivoTesteHandler implements Handler {
  final TesteUseCase testeUseCase;
  PostEnviarArquivoTesteHandler({required this.testeUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }

      final result = await testeUseCase.uploadFile(
        requestParams: requestParams,
      );

      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.internalError,
        body: result
            ? {'mensagem': 'Sucesso ao salvar o arquivo.'}
            : {'mensagem': 'Houveu um error ao criar o ticket de teste.'},
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

class GetBuscarArquivoTesteHandler implements Handler {
  final TesteUseCase testeUseCase;
  GetBuscarArquivoTesteHandler({required this.testeUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final bytes = await testeUseCase.downloadFile(
        requestParams: requestParams,
      );
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: bytes,
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

class DeleteTesteHandler implements Handler {
  final TesteUseCase testeUseCase;
  DeleteTesteHandler({required this.testeUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final result = await testeUseCase.delete(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Teste deletado com sucesso !!'}
            : {'mensagem': 'Houve um error ao deletar o teste !!'},
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        body: {'mensagem': 'Os campos title e aplicacao são obrigatórios.'},
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

class PutTesteHandler implements Handler {
  final TesteUseCase testeUseCase;
  PutTesteHandler({required this.testeUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await testeUseCase.update(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Teste atualizado com sucesso !!'}
            : {'mensagem': 'Houve um error ao atualizar o ticket !!'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class DeleteArquivoTesteHandler implements Handler {
  final TesteUseCase testeUseCase;
  DeleteArquivoTesteHandler({required this.testeUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result =
          await testeUseCase.deleteFile(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Arquivo(s) deletados com sucesso !!'}
            : {'mensagem': 'Houve um error ao atualizar o ticket !!'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}
