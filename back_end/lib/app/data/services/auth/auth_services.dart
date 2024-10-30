part of data;

class AuthService implements AuthUseCase {
  final AuthGateway authGateway;
  AuthService({required this.authGateway});

  @override
  Future<UserDto> login({required RequestParams requestParams}) async =>
      authGateway.login(requestParams: requestParams);

  @override
  Future<bool> changePassword({
    required RequestParams requestParams,
  }) async =>
      authGateway.changePassword(requestParams: requestParams);
}
