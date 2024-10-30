part of data;

abstract class UserGateway {
  Future<bool> getUserByEmail({required RequestParams requestParams});
  Future<bool> setThumbnailUser({
    required RequestParams requestParams,
  });
  Future<List<UserDto>> getAllUsers();
}
