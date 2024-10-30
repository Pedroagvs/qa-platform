part of data;

abstract class AuthGateway {
  Future<UserDto> login({required RequestParams requestParams});
  Future<bool> changePassword({required RequestParams requestParams});
}
