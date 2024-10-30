part of data;

class RegisterService implements RegisterUseCase {
  final RegisterGateway registerGateway;
  final UserGateway userGateway;
  RegisterService({
    required this.registerGateway,
    required this.userGateway,
  });

  @override
  Future<bool> call({
    required RequestParams requestParams,
  }) async {
    final exists =
        await userGateway.getUserByEmail(requestParams: requestParams);
    if (exists) {
      throw EmailAlreadyRegistered();
    }
    return registerGateway(requestParams: requestParams);
  }
}
