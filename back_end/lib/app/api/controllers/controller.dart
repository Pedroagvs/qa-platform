part of api;

abstract class Controller {
  final String route;
  final Map<String, Handler> handler;
  Controller({required this.route, required this.handler});
}
