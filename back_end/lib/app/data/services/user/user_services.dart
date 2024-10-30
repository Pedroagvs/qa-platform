part of data;

class UserService extends UserUseCase {
  final UserGateway userGateway;
  UserService({required this.userGateway});
  @override
  Future<List<UserDto>> getAllUsers() => userGateway.getAllUsers();

  @override
  Future<bool> setThumbnailUser({
    required RequestParams requestParams,
  }) =>
      userGateway.setThumbnailUser(requestParams: requestParams);

  @override
  Future<bool> getUserByEmail({
    required RequestParams requestParams,
  }) =>
      userGateway.getUserByEmail(requestParams: requestParams);
}
