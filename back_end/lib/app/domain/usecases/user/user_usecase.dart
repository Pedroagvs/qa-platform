part of domain;

abstract class UserUseCase {
  Future<bool> setThumbnailUser({
    required RequestParams requestParams,
  });
  Future<bool> getUserByEmail({
    required RequestParams requestParams,
  });
  Future<List<UserDto>> getAllUsers();
}
