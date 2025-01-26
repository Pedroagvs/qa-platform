part of api;

class AuthController implements Controller {
  final AuthHandler authHandler;
  AuthController({
    required this.authHandler,
  });
  @override
  String get route => '/auth';

  @override
  Map<String, Handler> get handler => {
        'POST': authHandler.login,
        'PUT /changePassword': authHandler.changePassword,
      };
}
