part of domain;

abstract class AuthUseCase {
  Future<UserDto> login({required RequestParams requestParams});
  Future<bool> changePassword({required RequestParams requestParams});
  Future<bool> createAccount({required RequestParams requestParams});
}
