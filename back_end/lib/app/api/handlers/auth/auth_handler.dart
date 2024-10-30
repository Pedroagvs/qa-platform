part of api;

class AuthHandler implements Handler {
  final AuthUseCase authUseCase;
  AuthHandler({required this.authUseCase});

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['senha'] == null ||
          requestParams.body!['email'] == null ||
          requestParams.body!['senha'].toString().isEmpty ||
          requestParams.body!['email'].toString().isEmpty) {
        throw NotExistsThisUser();
      }
      final userDto = await authUseCase.login(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: userDto,
      );
    } on NotExistsThisUser {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'E-mail ou senha inválidos'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}

class ChangePasswordHandler implements Handler {
  final AuthUseCase authUseCase;
  ChangePasswordHandler({required this.authUseCase});
  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['senha'] == null ||
          requestParams.body!['novaSenha'] == null ||
          requestParams.body!['senha'].toString().isEmpty ||
          requestParams.body!['novaSenha'].toString().isEmpty ||
          requestParams.body!['idUser'] == null ||
          requestParams.body!['idUser'] == null ||
          requestParams.body!['idUser'].toString().isEmpty ||
          requestParams.body!['idUser'].toString().isEmpty) {
        throw FieldsIsEmpty();
      }
      final result =
          await authUseCase.changePassword(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: result ? StatusHandler.ok : StatusHandler.badRequest,
        body: result
            ? {'mensagem': 'Sucesso ao alterar a senha.'}
            : {'mensagem': 'Erro ao alterar a senha.'},
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'Campos inválidos'},
      );
    } catch (e, s) {
      return ResponseHandler(
        statusHandler: StatusHandler.internalError,
        body: {'mensagem': e.toString(), 'stackTrace': s.toString()},
      );
    }
  }
}
