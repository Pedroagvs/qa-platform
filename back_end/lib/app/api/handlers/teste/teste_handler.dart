part of api;

class TesteHandler {
  final Handler create;
  final Handler update;
  final Handler delete;
  final Handler read;
  final Handler createFile;
  final Handler getFile;
  final Handler deleteFile;
  TesteHandler({
    required this.create,
    required this.delete,
    required this.read,
    required this.update,
    required this.createFile,
    required this.getFile,
    required this.deleteFile,
  });
}

class GetTestHandler implements Handler {
  final TestUseCase testUseCase;
  GetTestHandler({required this.testUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await testUseCase.get(requestParams: requestParams);
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

class CreateTestHandler implements Handler {
  final TestUseCase testUseCase;
  CreateTestHandler({required this.testUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final result = await testUseCase.create(requestParams: requestParams);
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

class UploadFileTestHandler implements Handler {
  final TestUseCase testUseCase;
  UploadFileTestHandler({required this.testUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }

      final result = await testUseCase.uploadFile(
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

class GetFilesTestHandler implements Handler {
  final TestUseCase testUseCase;
  GetFilesTestHandler({required this.testUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final bytes = await testUseCase.downloadFile(
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

class DeleteTestHandler implements Handler {
  final TestUseCase testUseCase;
  DeleteTestHandler({required this.testUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final result = await testUseCase.delete(requestParams: requestParams);
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

class UpdateTestHandler implements Handler {
  final TestUseCase testUseCase;
  UpdateTestHandler({required this.testUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await testUseCase.update(requestParams: requestParams);
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

class DeleteFileTestHandler implements Handler {
  final TestUseCase testUseCase;
  DeleteFileTestHandler({required this.testUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result = await testUseCase.deleteFile(requestParams: requestParams);
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
