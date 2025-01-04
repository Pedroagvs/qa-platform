part of api;

class AuthHandler {
  final Handler login;
  final Handler createAccount;
  final Handler changePassword;
  AuthHandler({
    required this.login,
    required this.createAccount,
    required this.changePassword,
  });
}

class LoginHandler implements Handler {
  final AuthUseCase authUseCase;
  LoginHandler({
    required this.authUseCase,
  });

  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['senha'] == null ||
          requestParams.body!['email'] == null ||
          requestParams.body!['senha'].toString().isEmpty ||
          requestParams.body!['email'].toString().isEmpty) {
        throw FieldsIsEmpty();
      }
      final userDto = await authUseCase.login(requestParams: requestParams);
      return ResponseHandler(
        statusHandler: StatusHandler.ok,
        body: userDto,
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        statusHandler: StatusHandler.badRequest,
        body: {'mensagem': 'E-mail ou senha inválidos'},
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
        statusHandler: result ? StatusHandler.ok : StatusHandler.internalError,
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

class CreateAccountHandler implements Handler {
  final AuthUseCase authUseCase;
  CreateAccountHandler({required this.authUseCase});
  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['nome'] == null ||
          requestParams.body!['email'] == null ||
          requestParams.body!['senha'] == null ||
          requestParams.body!['cargo'] == null ||
          requestParams.body!['nome'].toString().isEmpty ||
          requestParams.body!['cargo'].toString().isEmpty ||
          requestParams.body!['email'].toString().isEmpty ||
          requestParams.body!['senha'].toString().isEmpty) {
        throw FieldsIsEmpty();
      }
      if (requestParams.body!['email'] != null &&
          !validateEmail(requestParams.body!['email'])) {
        throw InvalidEmail();
      }

      final response = await authUseCase.createAccount(
        requestParams: requestParams,
      );

      return ResponseHandler(
        statusHandler:
            response ? StatusHandler.ok : StatusHandler.internalError,
        body: response
            ? {'mensagem': 'Usuário criado com sucesso !!'}
            : {'mensagem': 'Não foi possível criar o usuário !!'},
      );
    } on EmailAlreadyRegistered {
      return ResponseHandler(
        body: {'mensagem': 'E-mail já cadastrado !!.'},
        statusHandler: StatusHandler.badRequest,
      );
    } on FieldsIsEmpty {
      return ResponseHandler(
        body: {'mensagem': 'Todos os campos são obrigatórios.'},
        statusHandler: StatusHandler.badRequest,
      );
    } on InvalidEmail {
      return ResponseHandler(
        body: {'mensagem': 'E-mail inválido !!'},
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
