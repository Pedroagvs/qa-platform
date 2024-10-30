part of api;

class AuthController implements Controller {
  final AuthUseCase authUseCase;
  AuthController({required this.authUseCase});
  @override
  String get route => '/auth';

  @override
  Map<String, Handler> get handler => {
        'POST': AuthHandler(authUseCase: authUseCase),
        'PUT /changePassword': ChangePasswordHandler(authUseCase: authUseCase),
      };
}
