part of api;

class RegisterController implements Controller {
  final RegisterUseCase registerUseCase;
  RegisterController({required this.registerUseCase});
  @override
  String get route => '/register';
  @override
  Map<String, Handler> get handler => {
        'POST': RegisterHandler(registerUseCase: registerUseCase),
      };
}
