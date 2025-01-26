part of api;

class UserController implements Controller {
  final UserHandler userHandler;
  UserController({required this.userHandler});
  @override
  String get route => '/user';

  @override
  Map<String, Handler> get handler => {
        'GET': userHandler.getUsers,
        'PUT /thumbnail': userHandler.updateThumbnail,
        'GET /email': userHandler.getUserByEmail,
      };
}
