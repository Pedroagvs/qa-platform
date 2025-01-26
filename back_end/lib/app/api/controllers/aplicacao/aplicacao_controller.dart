part of api;

class AplicationController implements Controller {
  final AplicationHandler aplicationHandler;
  AplicationController({
    required this.aplicationHandler,
  });
  @override
  String get route => '/aplicacao';

  @override
  Map<String, Handler> get handler => {
        'GET': aplicationHandler.read,
        'POST': aplicationHandler.create,
        'PUT': aplicationHandler.update,
        'DELETE': aplicationHandler.delete,
      };
}
