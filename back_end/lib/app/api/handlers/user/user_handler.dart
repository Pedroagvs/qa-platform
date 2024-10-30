part of api;

class SetThumbnailUserHandler implements Handler {
  final UserUseCase userUseCase;
  SetThumbnailUserHandler({required this.userUseCase});
  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result =
          await userUseCase.setThumbnailUser(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Sucesso ao salvar a imagem.'}
            : {'mensagem': 'Erro ao salvar imagem.'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class GetUserByEmailHandler implements Handler {
  final UserUseCase userUseCase;
  GetUserByEmailHandler({required this.userUseCase});
  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final result =
          await userUseCase.getUserByEmail(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: result
            ? {'mensagem': 'Usuário encontrado !'}
            : {'mensagem': 'Usuário não encontrado !!'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class GetAllUsersHandler implements Handler {
  final UserUseCase userUseCase;
  GetAllUsersHandler({required this.userUseCase});
  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      final users = await userUseCase.getAllUsers();
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: users,
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}
