part of api;

class RegisterHandler implements Handler {
  final RegisterUseCase registerUseCase;
  RegisterHandler({required this.registerUseCase});
  @override
  Future<ResponseHandler> call({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['nome'] == null ||
          requestParams.body!['email'] == null ||
          requestParams.body!['senha'] == null ||
          requestParams.body!['nome'].toString().isEmpty ||
          requestParams.body!['email'].toString().isEmpty ||
          requestParams.body!['senha'].toString().isEmpty) {
        throw FieldsIsEmpty();
      }
      if (!validateEmail(requestParams.body!['email'])) {
        throw InvalidEmail();
      }

      final response = await registerUseCase(
        requestParams: requestParams,
      );

      return ResponseHandler(
        statusHandler: response ? StatusHandler.ok : StatusHandler.badRequest,
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
