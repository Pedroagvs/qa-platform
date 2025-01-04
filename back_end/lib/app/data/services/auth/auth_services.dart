part of data;

class AuthService implements AuthUseCase {
  final AuthGateway authGateway;
  final UserGateway userGateway;
  AuthService({
    required this.authGateway,
    required this.userGateway,
  });

  @override
  Future<UserDto> login({required RequestParams requestParams}) async =>
      authGateway.login(requestParams: requestParams);

  @override
  Future<bool> changePassword({
    required RequestParams requestParams,
  }) async =>
      authGateway.changePassword(requestParams: requestParams);

  @override
  Future<bool> createAccount({required RequestParams requestParams}) async {
    final exists =
        await userGateway.getUserByEmail(requestParams: requestParams);
    if (exists) throw EmailAlreadyRegistered();
    return authGateway.createAccount(requestParams: requestParams);
  }
}
