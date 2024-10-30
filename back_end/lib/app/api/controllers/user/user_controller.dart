part of api;

class UserController implements Controller {
  final UserUseCase userUseCase;
  UserController({required this.userUseCase});
  @override
  String get route => '/user';

  @override
  Map<String, Handler> get handler => {
        'GET': GetAllUsersHandler(
          userUseCase: userUseCase,
        ),
        'PUT /thumbnail': SetThumbnailUserHandler(
          userUseCase: userUseCase,
        ),
        'GET /email': GetUserByEmailHandler(
          userUseCase: userUseCase,
        ),
      };
}
